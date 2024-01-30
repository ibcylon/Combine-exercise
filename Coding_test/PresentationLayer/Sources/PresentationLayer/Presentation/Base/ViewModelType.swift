//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import Foundation
import Combine

protocol ViewModelType {
  typealias InputAction = AnyPublisher<Input, Never>
  typealias OutputAction = AnyPublisher<Output, Never>
  associatedtype Input
  associatedtype Output

  func transform(input: InputAction) -> OutputAction
}
