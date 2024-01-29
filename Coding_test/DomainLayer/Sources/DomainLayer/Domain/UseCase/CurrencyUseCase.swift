//
//  CurrencyUseCase.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation
import Combine

public protocol CurrencyUseCaseInterface {
  func realtimeRequest(currencies: [String], source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error>
  func historicalRequest(date: Date, source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error>
}

public final class DefaultCurrencyUseCase {
  private let repository: CurrencyRepositoryInterface

  public init(repository: CurrencyRepositoryInterface) {
    self.repository = repository
  }
}

extension DefaultCurrencyUseCase: CurrencyUseCaseInterface {
  public func realtimeRequest(currencies: [String], source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error> {
    repository.realtimeRequest(currencies: currencies, source: source.rawValue)
  }
  
  public func historicalRequest(date: Date, source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error> {
    repository.historicalRequest(date: date, source: source)
  }
}
