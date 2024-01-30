//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import Foundation
import Combine

import DomainLayer

public final class CurrencyViewModel: ViewModelType {
  enum Input {
    case onAppear
    case text(String)
    case selectedCurrency(CurrencyEntity)
  }

  enum Output {
    case exchangeInfo(CurrencyInfo)
    case receiptInfo(SelectCurrencyModel)
    case error(CurrencyError)
  }
  private let outputSubject = PassthroughSubject<Output, Never>()

  private let errorSubject = PassthroughSubject<String, Never>()

  let currencyInfo = PassthroughSubject<CurrencyInfo, Never>()

  private let currencyUseCase: CurrencyUseCaseInterface

  private var cancellable = Set<AnyCancellable>()

  public init(currencyUseCase: CurrencyUseCaseInterface) {
    self.currencyUseCase = currencyUseCase
  }

  func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    let currency = PassthroughSubject<CurrencyEntity, Never>()
    let amount = PassthroughSubject<Int, Never>()

    input
      .compactMap { [weak self] action -> (CurrencyViewModel, Input)? in
        guard let self = self else {
          return nil
        }
        return (self, action)
      }
      .sink { [weak self] owner, action in
        switch action {
        case .onAppear:
          self?.loadInfo()
        case .text(let text):
          if let amountInt = Int(text) {
            amount.send(amountInt)
          }
        case .selectedCurrency(let currencyEntity):
          currency.send(currencyEntity)
        }
      }.store(in: &cancellable)
    
    amount.combineLatest(currency, currencyInfo) { [weak self] currentAmount, currency, info -> SelectCurrencyModel? in
      guard Validator.amountValidator(amount: currentAmount) else {
        self?.outputSubject.send(.error(.invalidInput))
        self?.errorSubject.send("올바르지 않은 입력값입니다.")
        return nil
      }

      let rate = info.quotes[currency] ?? 0
      let exchangeRate = Double(currentAmount) * rate
      return SelectCurrencyModel(exchangeRate: exchangeRate, selectedCurrency: currency)
    }
    .compactMap { $0 }
    .sink { [weak self] select in
      self?.outputSubject.send(.receiptInfo(select))
    }.store(in: &cancellable)

    return outputSubject
      .eraseToAnyPublisher()
  }

  private func loadInfo() {
    self.currencyUseCase.realtimeRequest(
      currencies: CurrencyEntity.defaultCurrencies.map { $0.rawValue },
      source: .USD
    )
    .sink { completion in
      if case(.failure(let error)) = completion {
        print(error.localizedDescription)
      }
    } receiveValue: { [weak self] info in
      self?.outputSubject.send(.exchangeInfo(info))
      self?.currencyInfo.send(info)
    }
    .store(in: &cancellable)
  }
}

struct Validator {
  static func amountValidator(amount: Int) -> Bool {
    return ((0...10000) ~= amount )
  }
}

enum CurrencyError: Error {
  case invalidInput

  var message: String {
    switch self {
    case .invalidInput:
      "입력값이 올바르지 않습니다."
    }
  }
}
