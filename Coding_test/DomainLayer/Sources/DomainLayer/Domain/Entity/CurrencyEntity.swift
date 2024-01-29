//
//  Currency.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

public enum CurrencyEntity: String {
  case USD
  case JPY
  case KRW
  case PHP

  public var label: String {
    switch self {
    case .USD:
      return "미국(\(rawValue))"
    case .JPY:
      return "일본(\(rawValue))"
    case .KRW:
      return "한국(\(rawValue))"
    case .PHP:
      return "필리핀(\(rawValue))"
    }
  }
}

extension CurrencyEntity {
  public static var defaultCurrencies: [CurrencyEntity] {
    [
      .KRW,
      .JPY,
      .PHP
    ]
  }
}
