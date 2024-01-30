//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import Foundation
import DomainLayer

struct SelectCurrencyModel {
  let exchangeRate: Double
  let selectedCurrency: CurrencyEntity

  var infoText: String {
    "수취금액은 \(exchangeRate.toString()) \(selectedCurrency.rawValue)입니다."
  }
}
