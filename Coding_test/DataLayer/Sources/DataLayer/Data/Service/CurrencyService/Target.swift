//
//  EndPoint.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import Foundation

typealias Parameters = [String: Any]

enum Target {
  case realtime(request: RealtimeReq)
  case historicalRate(request: HistoricalReq)
}

extension Target {
  var baseURL: URL { URL(string: "http://api.currencylayer.com/")! }

  var path: String {
    switch self {
    case .realtime:
      return "/live"
    case .historicalRate:
      return "/historical"
    }
  }

  var method: String {
    return "get"
  }

  var parameters: Parameters {
    switch self {
    case .realtime(let request):
      return request.toDictionary()
    case .historicalRate(let request):
      return request.toDictionary()
    }
  }
}

extension Encodable {
  func toDictionary() -> Parameters {
    do {
      let data = try JSONEncoder().encode(self)
      let dic = try JSONSerialization.jsonObject(with: data) as? Parameters

      return dic ?? [:]
    } catch {
      return [:]
    }
  }
}
