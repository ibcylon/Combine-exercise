//
//  Target+SampleData.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

extension Target {
  public var sampleData: Data {
    let jsonLoader = JSONFileLoader()
    switch self {
    case .realtime:
      guard let data = jsonLoader.load(name: "CurrencySampleData", extensionType: .json) else {
        return Data("""
              """.utf8)
      }
      return data
    case .historicalRate:
      guard let data = jsonLoader.load(name: "CurrencySampleData", extensionType: .json) else {
        return Data("""
              """.utf8)
      }
      return data
    }
  }
}
