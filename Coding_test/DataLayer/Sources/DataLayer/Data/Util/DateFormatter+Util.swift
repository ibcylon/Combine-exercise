//
//  DateFormatter+Util.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation

extension Date {
  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-DD"

    return formatter.string(from: self)
  }
}
