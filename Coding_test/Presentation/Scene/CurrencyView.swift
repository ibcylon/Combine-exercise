//
//  CurrencyView.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit

public final class CurrencyView: UIView {
  private let leftPadding: CGFloat = 20

  private(set) lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = "환율 계산"
    label.font = .systemFont(ofSize: 40, weight: .regular)
    return label
  }()

  private(set) lazy var remittanceLabel: UILabel = .contentLabel("송금국가 : ")

  private(set) lazy var receiptLabel: UILabel = .contentLabel("수취국가 : ")

  private(set) lazy var exchangeRateLabel: UILabel = .contentLabel("환율 : ")
  private(set) lazy var timestampLabel: UILabel = .contentLabel("조회시간 : ")

  private(set) lazy var amountLabel: UILabel = UILabel.contentLabel("송금액 : ")

  private(set) lazy var textField: UITextField = {
    let textField = UITextField()
    textField.layer.borderColor = UIColor.darkGray.cgColor
    textField.layer.borderWidth = 1
    textField.textAlignment = .right
    textField.keyboardType = .numberPad
    return textField
  }()

  private(set) lazy var currenyLabel: UILabel = .contentLabel("USD")

  private(set) lazy var infoLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 23, weight: .regular)
    label.textColor = .darkGray
    label.text = "수취금액은 입니다."
    return label
  }()

  private(set) lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    return pickerView
  }()

  init() {
    super.init(frame: .zero)
    makeUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func makeUI() {
    [
      titleLabel,
      remittanceLabel,
      receiptLabel,
      exchangeRateLabel,
      timestampLabel,
      amountLabel, textField, currenyLabel,
      infoLabel,
      pickerView
    ].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    makeLayout()
  }

  func makeLayout() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
      titleLabel.heightAnchor.constraint(equalToConstant: 60),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      remittanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
      remittanceLabel.widthAnchor.constraint(equalToConstant: 100),
      remittanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.leftPadding),
      
      receiptLabel.topAnchor.constraint(equalTo: remittanceLabel.bottomAnchor),
      receiptLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      receiptLabel.widthAnchor.constraint(equalToConstant: 100),

      exchangeRateLabel.topAnchor.constraint(equalTo: receiptLabel.bottomAnchor),
      exchangeRateLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      exchangeRateLabel.widthAnchor.constraint(equalToConstant: 100),
      timestampLabel.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor),
      timestampLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      timestampLabel.widthAnchor.constraint(equalToConstant: 100),

      amountLabel.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor),
      amountLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      amountLabel.widthAnchor.constraint(equalToConstant: 100),

      textField.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
      textField.widthAnchor.constraint(equalToConstant: 100),
      currenyLabel.topAnchor.constraint(equalTo: amountLabel.topAnchor),
      currenyLabel.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
      infoLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 30),
      infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      infoLabel.heightAnchor.constraint(equalToConstant: 200),

      pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
      pickerView.heightAnchor.constraint(equalToConstant: 400)
    ])
  }

  func bind(_ model: String) {
    
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CurrencyViewPreview: PreviewProvider {

  static var previews: some View {
    UIViewPreview {
      return CurrencyView()
    }
    .previewLayout(.sizeThatFits)
  }
}
#endif
