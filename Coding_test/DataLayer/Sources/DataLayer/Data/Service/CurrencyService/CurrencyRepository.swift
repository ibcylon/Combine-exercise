//
//  CurrencyRepository.swift
//  Coding_test
//
//  Created by Kanghos on 2024/01/27.
//

import Foundation
import Combine

import DomainLayer

public final class CurrencyRepository {
  private let httpClient: HTTPClient
  private let token: String
  private var cacellable = Set<AnyCancellable>()

  public init(httpClient: HTTPClient, token: String) {
    self.httpClient = httpClient
    self.token = token
  }
}

extension CurrencyRepository: CurrencyRepositoryInterface {
  public func realtimeRequest(currencies: [String], source: String) -> AnyPublisher<CurrencyInfo, Error> {
    let query = RealtimeReq(accessKey: self.token, currencies: currencies, source: source)
    let endpoint = EndPoint(target: .realtime(request: query))
    
    return Future { promise in
      self.httpClient.request(request: endpoint.toRequest())
        .tryMap({ (data, response) in
          let decoder = JSONDecoder()
          guard let dto = try? decoder.decode(CurrencyResponse.self, from: data) else {
            do {
              let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
              throw DomainError.networkError(errorResponse.error)
            } catch let error as DecodingError {
              throw DomainError.decodedError(error)
            }
          }
          return dto.toDomain()
        })
        .sink { completion in
          if case .failure(let error) = completion {
            promise(.failure(error))
          }

        } receiveValue: { output in
          print(output)
          promise(.success(output))
        }
        .store(in: &self.cacellable)
    }.eraseToAnyPublisher()
  }
  
  public func historicalRequest(date: Date, source: CurrencyEntity) -> AnyPublisher<CurrencyInfo, Error> {
    let query = HistoricalReq(
      accessKey: Constant.CurrencyLayerAPIKey,
      date: date.toString(),
      source: source.rawValue
    )
    let endpoint = EndPoint(target: .historicalRate(request: query))

    return httpClient.request(request: endpoint.toRequest())
      .tryMap { (data, response) in
        let decoder = JSONDecoder()
        guard let dto = try? decoder.decode(CurrencyResponse.self, from: data) else {
          do {
            let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
            throw DomainError.networkError(errorResponse.error)
          } catch let error as DecodingError {
            throw DomainError.decodedError(error)
          }
        }
        return dto.toDomain()
      }
      .eraseToAnyPublisher()
  }
}
//
//extension Publisher {
//  public func errorModelDecode<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Self, Item, Coder> where Item : Decodable, Coder : TopLevelDecoder, Self.Output == Coder.Input {
//    
//  }
//}
