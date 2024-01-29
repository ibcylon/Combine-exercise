//
//  CurrencyStub.swift
//  Coding_testTests
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation
import XCTest
import DomainLayer
@testable import DataLayer

final class CurrencyRepositoryStub: XCTestCase {
  func test_jsonFile() throws {
    let loader = JSONFileLoader()

    guard let data = loader.load(name: "CurrencySampleData") else {
      assertionFailure("can load")
      return
    }
    guard let domain = try? JSONDecoder()
      .decode(CurrencyResponse.self, from: data)
      .toDomain() else {
      assertionFailure("can't decode")
      return
    }
    print(domain.quotes)
    assert(domain.quotes.count == 4)

  }

  func test_jsonEqualSample() throws {
    let request = RealtimeReq(accessKey: "", currencies: [CurrencyEntity.KRW.rawValue], source: "USD")
    let sampleData = Target.realtime(request: request).sampleData

    guard let domain = try? JSONDecoder().decode(CurrencyResponse.self, from: sampleData)
      .toDomain() else {
      assertionFailure("can't decode"); return
    }
    print(domain.quotes)
    assert(domain.quotes.count == 4)
  }
}
