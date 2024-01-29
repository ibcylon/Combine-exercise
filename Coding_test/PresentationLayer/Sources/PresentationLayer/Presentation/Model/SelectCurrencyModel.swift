//
//  File.swift
//  
//
//  Created by Kanghos on 2024/01/28.
//

import Foundation
import DomainLayer

struct SelectCurrencyModel {
  let receipt: CurrencyEntity
  let remittance: CurrencyEntity
  let exchangeRate: Double
  let timestamp: Double
  let receiptAmount: Double

}
