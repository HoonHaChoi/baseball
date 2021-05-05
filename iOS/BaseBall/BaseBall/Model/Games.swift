//
//  games.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

struct Game: Decodable {
    let gameId: Int
    let homeTeam: Team
    let awayTeam: Team
}

struct Team: Decodable {
    let teamId: Int
    let name: String
    let occupied: Bool
}

