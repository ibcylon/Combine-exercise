//
//  CustomError.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

enum CustomError: Error {
  case decodingFailed
  case invalidResponse(Int)
  case unknown
  case invalidURL(URLError)
}
