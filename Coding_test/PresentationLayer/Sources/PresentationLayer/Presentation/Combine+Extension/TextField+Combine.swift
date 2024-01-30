//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import UIKit
import Combine

extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: self)
      .compactMap { $0.object as? UITextField }
      .compactMap(\.text)
      .removeDuplicates()
      .debounce(for: 2, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
