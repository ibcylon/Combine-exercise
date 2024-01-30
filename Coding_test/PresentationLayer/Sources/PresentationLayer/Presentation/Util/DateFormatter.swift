//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/30.
//

import Foundation

import Foundation

extension Date {
  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-DD"

    return formatter.string(from: self)
  }
}
