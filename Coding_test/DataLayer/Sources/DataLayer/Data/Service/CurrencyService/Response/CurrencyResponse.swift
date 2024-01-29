//
//  CurrencyResponse.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation
import DomainLayer

// MARK: - CurrencyResponse
struct CurrencyResponse: Codable {
    let success: Bool
    let terms, privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

extension CurrencyResponse {
  func toDomain() -> CurrencyInfo {
    CurrencyInfo(
      success: success,
      terms: terms,
      privacy: privacy,
      timestamp: Date(timeIntervalSince1970: TimeInterval(timestamp)),
      source: CurrencyEntity(rawValue: source) ?? .USD,
      quotes: quotes.toDomain()
    )
  }
}

extension Dictionary where Dictionary.Key == String, Dictionary.Value == Double {
  func toDomain() -> [CurrencyEntity: Double] {
    var mutable: [CurrencyEntity: Double] = [:]
    for (key, value) in self {
      guard let currency = CurrencyEntity(rawValue: String(key.suffix(3))) else {
        continue
      }
      mutable.updateValue(value, forKey: currency)
    }
    return mutable
  }
}
