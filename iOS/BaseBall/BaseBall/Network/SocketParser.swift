//
//  SocketParser.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import Foundation

class SocketParser {
    
    static func convert<T: Decodable>(data: Any) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)
    }
    static func convert<T: Decodable>(data: [Any]) throws -> [T] {
        return try data.map{ (dict) -> T in
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
        }
    }
}
