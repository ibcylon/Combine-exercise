//
//  BaseRequest.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation

protocol AuthRequest {
  var accessKey: String { get }
}

struct BaseRequest: AuthRequest, Encodable {
  let accessKey: String

  private enum CodingKeys: String, CodingKey {
    case accessKey = "access_key"
  }
}
