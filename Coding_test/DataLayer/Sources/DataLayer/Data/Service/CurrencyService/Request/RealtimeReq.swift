//
//  RealtimeReq.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation

struct RealtimeReq: Encodable, AuthRequest {
  let accessKey: String
  let currencies: [String]
  let source: String

  private enum CodingKeys: String, CodingKey {
    case accessKey = "access_key"
    case currencies
    case source
  }
}
