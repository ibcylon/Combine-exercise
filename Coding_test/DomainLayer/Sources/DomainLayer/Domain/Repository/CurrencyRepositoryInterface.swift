//
//  CurrencyRepositoryInterface.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation
import Combine

public protocol CurrencyRepositoryInterface {
  func realtimeRequest(currencies: [String], source: String) -> AnyPublisher<CurrencyInfo, Error>
  func historicalRequest(date: Date, source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error>
}
