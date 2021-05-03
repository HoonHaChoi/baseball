//
//  EndPoint.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

enum EndPoint {
    private static let scheme = ""
    private static let host = ""
    private static let path = ""
    
    static func url() -> URL? {
        var componets = URLComponents()
        componets.scheme = EndPoint.scheme
        componets.host = EndPoint.host
        componets.path = EndPoint.path
        return componets.url
    }
}
