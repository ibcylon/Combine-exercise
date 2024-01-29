//
//  Coding_testTests.swift
//  Coding_testTests
//
//  Created by Kanghos on 2024/01/25.
//

import XCTest
import Combine

import DomainLayer
@testable import DataLayer

final class Coding_testTests: XCTestCase {
  var subscriptions = Set<AnyCancellable>()
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    subscriptions = []
  }

//  https://cocoacasts.com/how-to-add-app-transport-security-exception-domains
  // http exception domain 추가하는 법
  // https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
  func test_HTTPClientStatusCode200() throws {
    // Given
    let request = makeRealtimeRequest(isValidKey: false)
    let session = URLSession(configuration: .ephemeral)
    var error: Error?
    let expectaion = self.expectation(description: "invalidResponse")
    var statusCode: Int = -1

    // When
    session.request(request: request)
      .sink { response in
        print(response)
        switch response {
        case .finished: break
        case .failure(let networkError):
          error = networkError
        }
        expectaion.fulfill()
      } receiveValue: { data, response in
        statusCode = response.statusCode
      }.store(in: &subscriptions)

    // Then
    waitForExpectations(timeout: 2)
    print("status code: ", statusCode)
    XCTAssertNil(error)
    XCTAssertEqual(statusCode, 200)
  }

  func test_invalidAccessKey_code_101() throws {
    // Given
    let session = URLSession(configuration: .ephemeral)
    let repository = makeCurrencyRepository(client: session, token: "1234")
    var domainError: DomainError?

    let expectaion = self.expectation(description: "test_invalidAccessKey_code_101")
    var result: Int?
    let expected = 101
    // When
    repository.realtimeRequest(currencies: [], source: "USD")
      .sink { response in
        print(response)
        switch response {
        case .finished: break
        case .failure(let networkError):
          if let receivedDomainError = networkError as? DomainError {
            domainError = receivedDomainError
          }
        }
        expectaion.fulfill()
      } receiveValue: { receivedDomain in
        print(receivedDomain)
      }.store(in: &subscriptions)

    // Then
    waitForExpectations(timeout: 2)
    if case let .networkError(errorType) = domainError {
      result = errorType.code
    }
    print("status code: ", domainError?.description ?? "")
    XCTAssertEqual(expected, result)
  }

  func test_invalid_source_code_201() throws {
    // Given
    let session = URLSession(configuration: .ephemeral)
    let repository = makeCurrencyRepository(client: session, token: Constant.CurrencyLayerAPIKey)
    var domainError: DomainError?

    let expectaion = self.expectation(description: "test_invalid_source_code_201")
    var result: Int?
    let expected = 201

    // When
    repository.realtimeRequest(currencies: [], source: "ZZZ")
      .sink { response in
        print(response)
        switch response {
        case .finished: break
        case .failure(let networkError):
          if let receivedDomainError = networkError as? DomainError {
            domainError = receivedDomainError
          }
        }
        expectaion.fulfill()
      } receiveValue: { receivedDomain in
        print(receivedDomain)
      }.store(in: &subscriptions)

    // Then
    waitForExpectations(timeout: 2)
    if case let .networkError(errorType) = domainError {
      result = errorType.code
    }
    print("status code: ", domainError?.description ?? "")
    XCTAssertEqual(expected, result)
  }

  func test_invalid_currency_code_202() throws {
    // Given
    let session = URLSession(configuration: .ephemeral)
    let repository = makeCurrencyRepository(client: session, token: Constant.CurrencyLayerAPIKey)
    var domainError: DomainError?

    let expectaion = self.expectation(description: "test_invalid_currency_code_202")
    var result: Int?
    let expected = 202

    // When
    repository.realtimeRequest(currencies: ["ZZZ","AAA"], source: "USD")
      .sink { response in
        print(response)
        switch response {
        case .finished: break
        case .failure(let networkError):
          if let receivedDomainError = networkError as? DomainError {
            domainError = receivedDomainError
          }
        }
        expectaion.fulfill()
      } receiveValue: { receivedDomain in
        print(receivedDomain)
      }.store(in: &subscriptions)

    // Then
    waitForExpectations(timeout: 2)
    if case let .networkError(errorType) = domainError {
      result = errorType.code
    }
    print("status code: ", domainError?.description ?? "")
    XCTAssertEqual(expected, result)
  }

  func test_invalid_dateformat_code_302() throws {
    // Given
    let session = URLSession(configuration: .ephemeral)
    let repository = makeCurrencyRepository(client: session, token: Constant.CurrencyLayerAPIKey)
    var domainError: DomainError?

    let expectaion = self.expectation(description: "test_invalid_dateformat_code_302")
    var result: Int?
    let expected = 302

    let date = Date(timeIntervalSinceNow: 1000000000000)

    // When
    repository.historicalRequest(date: date, source: .USD)
      .sink { response in
        print(response)
        switch response {
        case .finished: break
        case .failure(let networkError):
          if let receivedDomainError = networkError as? DomainError {
            domainError = receivedDomainError
          }
        }
        expectaion.fulfill()
      } receiveValue: { receivedDomain in
        print(receivedDomain)
      }.store(in: &subscriptions)

    // Then
    waitForExpectations(timeout: 2)
    if case let .networkError(errorType) = domainError {
      result = errorType.code
    }
    print("status code: ", domainError?.description ?? "")
    XCTAssertEqual(expected, result)
  }

  private func makeCurrencyRepository(client: HTTPClient, token: String) -> CurrencyRepositoryInterface {
    CurrencyRepository(httpClient: client, token: token)
  }

  private func makeRealtimeRequest(isValidKey: Bool, source: String = "USD") -> URLRequest {
    let key = isValidKey ? Constant.CurrencyLayerAPIKey : "1234"
    let request = RealtimeReq(accessKey: key, currencies: [CurrencyEntity.JPY.rawValue], source: source)
    let target = Target.realtime(request: request)
    let endPoint = EndPoint(target: target)
    let urlRequest = endPoint.toRequest()
    return urlRequest
  }

  func test_EndPoint_currencies() throws {
    let request = RealtimeReq(accessKey: Constant.CurrencyLayerAPIKey, currencies: ["ZZZ", "AAA"], source: "USD")
    let target = Target.realtime(request: request)
    let endPoint = EndPoint(target: target)
    let urlReuest = endPoint.toRequest()
    print(urlReuest.url)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
