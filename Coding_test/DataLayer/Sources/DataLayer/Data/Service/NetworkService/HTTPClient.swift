//
//  NetworkHandler.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation
import Combine

public typealias NetworkResponse = (Data, HTTPURLResponse)

public protocol HTTPClient {
  func request(request: URLRequest) -> AnyPublisher<NetworkResponse, Error>
}

extension URLSession: HTTPClient {
  public func request(request: URLRequest) -> AnyPublisher<NetworkResponse, Error>  {
    print("==========Request URL START==========")
    print(request.httpMethod ?? "method")
    print(request.url ?? "URL")
    print("==========Request URL END==========")
    return self.dataTaskPublisher(for: request)
      .tryMap { data, response -> NetworkResponse in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw CustomError.unknown
        }
        guard httpResponse.statusCode == 200 else {
          throw CustomError.invalidResponse(httpResponse.statusCode)
        }
        return NetworkResponse(data, httpResponse)
      }.eraseToAnyPublisher()
  }
}

