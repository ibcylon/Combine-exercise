//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import UIKit
import Combine

extension UITextField {
  struct publisher: Publisher {
    typealias Output = String
    typealias Failure = Never

    func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
      let subscription = TextFieldSubscription(subscriber: subscriber)
      subscriber.receive(subscription: subscription)
    }
  }
}

fileprivate class TextFieldSubscription<S>: Subscription where S: Subscriber, S.Input == String, S.Failure == Never {
  typealias Output = String
  typealias Failure = Never

  var subscriber: S?
  var currentDemand: Subscribers.Demand = .none
 
  init(subscriber: S) {
    self.subscriber = subscriber
    upload()
  }

  func request(_ demand: Subscribers.Demand) {
    currentDemand = demand
  }

  func cancel() {
    subscriber = nil
  }

  func upload() {

  }
}
