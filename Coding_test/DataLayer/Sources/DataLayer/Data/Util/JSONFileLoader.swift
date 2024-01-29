//
//  JSONFileLoader.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//


// https://jiseobkim.github.io/swift/network/2021/05/16/swift-JSON-%ED%8C%8C%EC%9D%BC-%EB%B6%88%EB%9F%AC%EC%98%A4%EA%B8%B0.html

import Foundation

struct JSONFileLoader {

  enum ExtensionType: String {
    case json
  }

  func load(name: String, extensionType: ExtensionType = .json) -> Data? {
    do {
      guard 
        let fileLocation = Bundle.main.url(forResource: name, withExtension: extensionType.rawValue),
        let data = FileManager.default.contents(atPath: fileLocation.path)
      else {
        return nil
      }
      return data
    }
  }
}


