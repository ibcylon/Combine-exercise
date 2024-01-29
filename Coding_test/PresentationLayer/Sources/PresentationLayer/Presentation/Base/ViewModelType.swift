//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output
}
