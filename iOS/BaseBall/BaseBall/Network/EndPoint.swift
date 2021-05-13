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
        if index != nil {
            componets.path += "/status"
        }
        componets.queryItems = addQueryItem(at: index)
        return componets.url
    }

    private static func addQueryItem(at index: Int?) -> [URLQueryItem]? {
        index != nil ? [URLQueryItem(name: "gameId", value: "\(index ?? 0)")] : nil
    }
    
    static func URL<T>(type: T,game gameindex: Int,team teamindex: Int) -> URL? {
        var componets = URLComponents()
        componets.scheme = EndPoint.scheme
        componets.host = EndPoint.host
        componets.port = EndPoint.port
        componets.path = EndPoint.path + "\(type)"
        componets.queryItems = addPitchQueryItem(gameIndex: gameindex, teamIndex: teamindex)
        return componets.url
    }
    
    private static func addPitchQueryItem(gameIndex: Int, teamIndex: Int) -> [URLQueryItem]? {
        return [
            URLQueryItem(name: "gameId", value: "\(gameIndex)"),
            URLQueryItem(name: "teamId", value: "\(teamIndex)")
        ]
    }
}

enum URLType {
    case games
    case game
    case pitch
    case occupy
}
