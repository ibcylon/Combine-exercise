//
//  DomainError.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

public protocol NetworkErrorType: CustomStringConvertible {
  var code: Int { get }
  var info: String { get }
}

extension NetworkErrorType {
  public var description: String {
    "\(code): \(info)"
  }
}

public enum DomainError: Error, CustomStringConvertible {
  case message(String)
  case networkError(NetworkErrorType)
  case decodedError(DecodingError)

  public var description: String {
    switch self {
    case .message(let string):
      return string
    case .networkError(let error):
      return error.description
    case .decodedError(let decodingError):
      return "decodingerror"
    }
  }
}
