//
//  ViewController.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit

final class CurrencyViewController: UIViewController {
  private lazy var mainView = CurrencyView()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func loadView() {
    self.view = mainView
  }

  override func viewDidLoad() {
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
    CurrencyViewController().showPreview()
    .previewLayout(.sizeThatFits)
  }
}
#endif
