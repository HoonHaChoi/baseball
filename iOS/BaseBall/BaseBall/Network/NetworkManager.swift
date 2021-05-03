//
//  NetworkManager.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation
import Combine

protocol NetworkManagable {
    func requestResource<T: Decodable>(decodeType: T.Type) -> AnyPublisher<T, NetworkError>
}

final class NetworkManager: NetworkManagable {
    
    func requestResource<T: Decodable>(decodeType: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = EndPoint.url() else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(url: url, decodeType: T.self)
    }
    
    private func request<T: Decodable>(url: URL, decodeType: T.Type) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in
                NetworkError.invalidRequest
            }
            .flatMap { (data, response) -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    return Fail(error: NetworkError.invalidStatusCode(httpResponse.statusCode))
                        .eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in
                        NetworkError.failParsing
                    }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
}
