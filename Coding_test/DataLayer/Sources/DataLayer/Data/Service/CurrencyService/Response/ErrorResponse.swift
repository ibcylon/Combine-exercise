//
//  ErrorDTO.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation
import DomainLayer

struct ErrorResponse: Decodable {
  let success: Bool
  let error: ErrorMessage

  struct ErrorMessage: NetworkErrorType, Decodable {
    let code: Int
    let info: String
  }
}
