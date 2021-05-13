//
//  SocketData.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/11.
//

import Foundation

enum SocketRequestType : String, CodingKey {
    case join
    case out
    case occupy
}

struct SocketMessage : Codable {
    var type : String
    let gameId : Int
    let teamId : Int
}

struct SocketResponse {
    static let success = "\"success\""
    static let waiting = "\"waiting\""
    static let fail = "\"fail\""
}
struct SocketRequest {
    static let join = "join"
    static let out = "out"
    static let occupy = "occupy"
    static let leave = "leave"
    static let pitch = "pitch"
}

