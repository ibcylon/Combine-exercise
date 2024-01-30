//
//  AppCompositeRoot.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/30.
//

import UIKit

import DomainLayer
import DataLayer
import PresentationLayer

protocol Launcher {
  func launch(window: UIWindow)
}

final class AppCompositeRoot: Launcher {

  private let factory: ViewControllerFactory

  init() {
    self.factory = ViewControllerFactory()
  }

  func launch(window: UIWindow) {
    let currencyVC = factory.makeCurrencyViewController()
    let nav = UINavigationController(rootViewController: currencyVC)
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }
}
