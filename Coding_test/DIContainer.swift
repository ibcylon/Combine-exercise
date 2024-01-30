//
//  DIContainer.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/30.
//

import Foundation

import DomainLayer
import DataLayer

final class DIContainer {
  static var shared = DIContainer()
  private init() { }

  lazy var session: URLSession = {
    URLSession(configuration: .ephemeral)
  }()

  lazy var useCase: CurrencyUseCaseInterface = {
    DefaultCurrencyUseCase(repository: repository)
  }()

  lazy var repository: CurrencyRepositoryInterface = {
    CurrencyRepository(httpClient: session, token: Constant.CurrencyLayerAPIKey)
  }()
}
