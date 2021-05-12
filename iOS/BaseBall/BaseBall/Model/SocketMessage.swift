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
