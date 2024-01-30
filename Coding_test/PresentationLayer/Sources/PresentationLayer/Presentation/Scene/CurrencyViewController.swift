//
//  ViewController.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit
import Combine

public final class CurrencyViewController: UIViewController {
  private lazy var mainView = CurrencyView()
  private let viewModel: CurrencyViewModel

  private var cancellable = Set<AnyCancellable>()
  private let inputAction = PassthroughSubject<CurrencyViewModel.Input, Never>()
  public init(viewModel: CurrencyViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  public override func loadView() {
    self.view = mainView
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    binding()
    inputAction.send(.onAppear)
  }


  func binding() {
    mainView.textField.textPublisher
      .sink { [weak self] text in
        self?.inputAction.send(.text(text))
      }.store(in: &cancellable)

    mainView.currencySelectSubject
      .sink { [weak self] output in
        self?.inputAction.send(.selectedCurrency(output))
      }.store(in: &cancellable)

    let output = viewModel.transform(input: inputAction.eraseToAnyPublisher())

    output
      .receive(on: RunLoop.main)
      .sink { [weak self] outputAction in
        switch outputAction {
        case .exchangeInfo(let currencyInfo):
          self?.mainView.bind(currencyInfo)
        case .receiptInfo(let selectCurrencyModel):
          self?.mainView.calculate(selectCurrencyModel)
        case .error(let error):
          self?.mainView.errorBind(error)
        }
      }
      .store(in: &cancellable)
  }
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct CurrencyVCPreview: PreviewProvider {
//  
//  static var previews: some View {
//    viewController
//      .showPreview()
//      .previewLayout(.sizeThatFits)
//  }
//}
//#endif
