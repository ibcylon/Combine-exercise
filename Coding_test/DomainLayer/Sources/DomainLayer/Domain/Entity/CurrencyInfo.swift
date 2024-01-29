//
//  CurrencyResponse.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

// MARK: - CurrencyResponse
public struct CurrencyInfo {
    public let success: Bool
    public let terms, privacy: String
    public let timestamp: Date
    public let source: CurrencyEntity
    public let quotes: [CurrencyEntity: Double]

  public init(
    success: Bool,
    terms: String,
    privacy: String,
    timestamp: Date,
    source: CurrencyEntity,
    quotes: [CurrencyEntity : Double]
  ) {
    self.success = success
    self.terms = terms
    self.privacy = privacy
    self.timestamp = timestamp
    self.source = source
    self.quotes = quotes
  }
}
