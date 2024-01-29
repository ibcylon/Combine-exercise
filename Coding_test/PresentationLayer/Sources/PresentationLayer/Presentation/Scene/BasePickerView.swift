//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import UIKit
import DomainLayer

protocol BasePickerViewDelegate: AnyObject {
  func didSelectItem(_ item: CurrencyEntity)
}

protocol PickerRepresentable {
  associatedtype Item
  var pickerView: UIPickerView { get set }
  var dataList: [Item] { get set }
  var delegate: BasePickerViewDelegate? { get }
}
class BasePickerView: UIView, PickerRepresentable {
  
  weak var delegate: BasePickerViewDelegate?

  typealias Item = CurrencyEntity
  var dataList: [Item] = [] {
    didSet {
      DispatchQueue.main.async {
        self.pickerView.reloadAllComponents()
      }
    }
  }

  lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerView.translatesAutoresizingMaskIntoConstraints = false
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
    self.addSubview(pickerView)

    NSLayoutConstraint.activate([
      pickerView.topAnchor.constraint(equalTo: self.topAnchor),
      pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  func bind(_ dataList: [Item]) {
    self.dataList = dataList
  }
}

extension BasePickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let row = dataList[row]
    return row.label
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let row = dataList[row]
    self.delegate?.didSelectItem(row)
  }
}


extension BasePickerView: UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return dataList.count
  }
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
}
