//
//  ViewControllerFactory.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/30.
//

import UIKit

import PresentationLayer

final class ViewControllerFactory {

  func makeCurrencyViewController() -> UIViewController {
    let viewModel = CurrencyViewModel(currencyUseCase: DIContainer.shared.useCase)
    let viewController = CurrencyViewController(viewModel: viewModel)
    return viewController
  }
}
