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
  struct Input {
    let onAppear: AnyPublisher<Void, Never>
    let text: AnyPublisher<String, Never>
    let selectedCurrency: AnyPublisher<CurrencyEntity, Never>
  }

  struct Output {
    let exchangeInfo: AnyPublisher<CurrencyInfo, Never>
    let receiptInfo: AnyPublisher<SelectCurrencyModel, Never>
  }

  private let currencyUseCase: CurrencyUseCaseInterface

  public init(currencyUseCase: CurrencyUseCaseInterface) {
    self.currencyUseCase = currencyUseCase
  }

  func transform(input: Input) -> Output {

    let currencyInfo = input.onAppear
      .flatMap { [weak self] _ in
      guard let self = self else { return }
      return self.currencyUseCase.realtimeRequest(
        currencies: CurrencyEntity.defaultCurrencies.map { $0.rawValue },
        source: .USD
      )
    }


    return Output()
  }
}
