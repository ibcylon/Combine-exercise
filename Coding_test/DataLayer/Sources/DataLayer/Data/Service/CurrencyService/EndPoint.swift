//
//  EndPoint.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation

struct EndPoint {
  let target: Target

  func toRequest() -> URLRequest {
    var components = URLComponents(string: target.baseURL.absoluteString)!

    if !target.path.isEmpty {
      components.path = target.path
    }
    if !target.parameters.isEmpty {
      var queryItems: [URLQueryItem] = []
      for (key, value) in target.parameters where "\(value)".isEmpty == false  {
        let item: URLQueryItem
        if let array = value as? Array<Any> {
          let mutable = String(array.map { "\($0)" }.joined(separator: ","))
          item = .init(name: key, value: mutable)
        } else {
          item = URLQueryItem(name: key, value: "\(value)")
        }
        queryItems.append(item)
      }
      components.queryItems = queryItems
    }
    let endPoint = components.url ?? target.baseURL
    let request = URLRequest(url: endPoint)

    return request
  }
}
