//
//  UILabel+Util.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit

extension UILabel {
  static func contentLabel(_ text: String = "") -> UILabel {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textColor = .lightGray
    label.textAlignment = .right
    label.text = text//String(String(format: " %@", text).padding(toLength: 8, withPad: " ", startingAt: 0).reversed())
    return label
  }
}
