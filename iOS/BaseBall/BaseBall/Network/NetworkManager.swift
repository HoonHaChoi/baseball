//
//  NetworkManager.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation
import Combine

protocol NetworkManagable {
    func requestResource<T: Decodable>(gameURL: URLType, decodeType: T.Type, at index: Int?) -> AnyPublisher<T, NetworkError>
}

final class NetworkManager: NetworkManagable {
    
    func requestResource<T: Decodable>(gameURL: URLType, decodeType: T.Type, at index: Int? = nil) -> AnyPublisher<T, NetworkError> {
        guard let url = EndPoint.URL(type: gameURL, at: index) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(url: url)
    }
    
    func requestPitchResource<T: Decodable>(gameURL: URLType, decodeType: T.Type, gameIndex: Int, teamIndex: Int) -> AnyPublisher<T, NetworkError> {
        guard let url = EndPoint.URL(type: gameURL, game: gameIndex, team: teamIndex) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(url: url)
    }
    
    private func request<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
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
