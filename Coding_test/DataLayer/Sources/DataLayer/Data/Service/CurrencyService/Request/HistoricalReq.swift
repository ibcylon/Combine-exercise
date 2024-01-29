//
//  HistoricalReq.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation

struct HistoricalReq: Encodable, AuthRequest {
  let accessKey: String
  let date: String
  let source: String

  private enum CodingKeys: String, CodingKey {
    case accessKey = "access_key"
    case date, source
  }
}
