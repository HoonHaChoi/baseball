//
//  EndPoint.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

enum EndPoint {
    private static let scheme = "http"
    private static let host = "15.164.68.136"
    private static let port = 80
    private static let path = "/api/"
    
    static func URL<T>(type: T, at index: Int? = nil) -> URL? {
        var componets = URLComponents()
        componets.scheme = EndPoint.scheme
        componets.host = EndPoint.host
        componets.port = EndPoint.port
        componets.path = EndPoint.path + "\(type)"
        if let index = index {
            let indexString = String(index)
            componets.path += "/\(indexString)"
        }
        return componets.url
    }
    
    private static func addQueryItem(at index: Int?) -> [URLQueryItem]? {
        index != nil ? [URLQueryItem(name: "id", value: "\(index ?? 0)")] : nil
    }
    
}

enum URLType {
    case games
    case game
    case pitch
    case occupy
}

enum SocketEndPoint {
    static let baseURL = URL(string: "ws://15.164.68.136:80/ws/join")!
}
