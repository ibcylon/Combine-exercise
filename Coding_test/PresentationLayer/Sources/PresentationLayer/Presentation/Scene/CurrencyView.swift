//
//  CurrencyView.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/25.
//

import UIKit
import Combine

import DomainLayer

public final class CurrencyView: UIView {
  private let leftPadding: CGFloat = 20

  private(set) lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = "환율 계산"
    label.font = .systemFont(ofSize: 40, weight: .regular)
    return label
  }()

  private(set) var currencySelectSubject = PassthroughSubject<CurrencyEntity, Never>()

  private(set) lazy var remittanceLabel: UILabel = .contentNameLabel("송금국가 : ")
  private(set) lazy var remittanceContentLabel: UILabel = .contentLabel("송금국가 : ")

  private(set) lazy var receiptLabel: UILabel = .contentNameLabel("수취국가 : ")
  private(set) lazy var receiptContentLabel: UILabel = .contentLabel("수취국가 : ")


  private(set) lazy var exchangeRateLabel: UILabel = .contentNameLabel("환율 : ")
  private(set) lazy var exchangeContentRateLabel: UILabel = .contentLabel("환율 : ")
  private(set) lazy var timestampLabel: UILabel = .contentNameLabel("조회시간 : ")
  private(set) lazy var timestampContentLabel: UILabel = .contentLabel("조회시간 : ")

  private(set) lazy var amountLabel: UILabel = UILabel.contentNameLabel("송금액 : ")

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
    label.numberOfLines = 2
    return label
  }()

  private lazy var pickerView: BasePickerView = {
    let pickerView = BasePickerView()
    pickerView.delegate = self
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
      remittanceLabel, remittanceContentLabel,
      receiptLabel, receiptContentLabel,
      exchangeRateLabel, exchangeContentRateLabel,
      timestampLabel, timestampContentLabel,
      amountLabel, textField, currenyLabel,
      infoLabel,
      pickerView
    ].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    self.backgroundColor = .white

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

      remittanceContentLabel.topAnchor.constraint(equalTo: remittanceLabel.topAnchor),
      remittanceContentLabel.leadingAnchor.constraint(equalTo: remittanceLabel.trailingAnchor, constant: 10),
      remittanceContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.leftPadding),

      receiptLabel.topAnchor.constraint(equalTo: remittanceLabel.bottomAnchor),
      receiptLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      receiptLabel.widthAnchor.constraint(equalToConstant: 100),
      receiptContentLabel.topAnchor.constraint(equalTo: receiptLabel.topAnchor),
      receiptContentLabel.leadingAnchor.constraint(equalTo: receiptLabel.trailingAnchor, constant: 10),
      receiptContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.leftPadding),

      exchangeRateLabel.topAnchor.constraint(equalTo: receiptLabel.bottomAnchor),
      exchangeRateLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      exchangeRateLabel.widthAnchor.constraint(equalToConstant: 100),
      exchangeContentRateLabel.topAnchor.constraint(equalTo: exchangeRateLabel.topAnchor),
      exchangeContentRateLabel.leadingAnchor.constraint(equalTo: exchangeRateLabel.trailingAnchor, constant: 10),
      exchangeContentRateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.leftPadding),

      timestampLabel.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor),
      timestampLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      timestampLabel.widthAnchor.constraint(equalToConstant: 100),
      timestampContentLabel.topAnchor.constraint(equalTo: timestampLabel.topAnchor),
      timestampContentLabel.leadingAnchor.constraint(equalTo: timestampLabel.trailingAnchor, constant: 10),
      timestampContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.leftPadding),

      amountLabel.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor),
      amountLabel.leadingAnchor.constraint(equalTo: remittanceLabel.leadingAnchor),
      amountLabel.widthAnchor.constraint(equalToConstant: 100),

      textField.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 10),
      textField.widthAnchor.constraint(equalToConstant: 130),
      currenyLabel.topAnchor.constraint(equalTo: amountLabel.topAnchor),
      currenyLabel.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
      infoLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 30),
      infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      infoLabel.heightAnchor.constraint(equalToConstant: 200),

      pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  func bind(_ model: CurrencyInfo) {
    self.bindQuotos(model.quotes.map { $0.key })
    self.remittanceContentLabel.text = model.source.label

    if let (key, value) = model.quotes.first {
      self.receiptContentLabel.text = key.rawValue
      self.exchangeContentRateLabel.text = String(value)
      self.currencySelectSubject.send(key)
    } else {
      self.receiptContentLabel.text = ""
      self.exchangeContentRateLabel.text = ""
    }
    self.timestampContentLabel.text = model.timestamp.toString()
    self.currenyLabel.text = model.source.rawValue
  }

  func bindQuotos(_ model: [CurrencyEntity]) {
    self.pickerView.bind(model)
  }

  func calculate(_ model: SelectCurrencyModel) {
    self.infoLabel.text = model.infoText
    self.receiptContentLabel.text = model.selectedCurrency.rawValue
    self.exchangeContentRateLabel.text = String(model.exchangeRate)
  }

  func errorBind(_ error: CurrencyError) {
    self.infoLabel.text = error.message
  }
}

extension CurrencyView: BasePickerViewDelegate {
  func didSelectItem(_ item: CurrencyEntity) {
    print(item)
    currencySelectSubject.send(item)
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CurrencyViewPreview: PreviewProvider {

  static var previews: some View {
    UIViewPreview {
      let view = CurrencyView()
      view.bind(.init(success: true, terms: "", privacy: "", timestamp: Date(), source: .USD, quotes: [.JPY: 0.0]))
      view.bindQuotos([.JPY, .PHP, .USD])
      return view
    }
    .previewLayout(.sizeThatFits)
  }
}
#endif
