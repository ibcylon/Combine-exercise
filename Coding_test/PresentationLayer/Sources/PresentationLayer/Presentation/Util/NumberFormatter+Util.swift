//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/30.
//

import Foundation

extension Double {
  func toString() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    let value =  self as NSNumber
    return formatter.string(from: value) ?? ""
  }
}
