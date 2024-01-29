//
//  ViewController.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit

public final class CurrencyViewController: UIViewController {
  private lazy var mainView = CurrencyView()
  private let viewModel: CurrencyViewModel

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
  }

  func binding() {
    
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CurrencyVCPreview: PreviewProvider {
  
  static var previews: some View {
    let viewModel = CurrencyViewModel()
    let viewController = CurrencyViewController(viewModel: viewModel)
    viewController
      .showPreview()
      .previewLayout(.sizeThatFits)
  }
}
#endif
