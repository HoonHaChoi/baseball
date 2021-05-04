//
//  games.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

struct Games: Decodable {
    let games : [game]
}

struct game: Decodable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
}

struct Team: Decodable {
    let name: String
    let isOccupied: Bool
}

