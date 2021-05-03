//
//  GameInfo.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

struct GameInfo: Decodable {
    let id: Int
    let homeTeam, awayTeam: TeamInfo
    let statusBoard: StatusBoard
    let pitckerOnMound: PitckerOnMound
    let batterInBox: BatterInBox
    let recordOfPitching: [RecordOfPitching]
}

struct TeamInfo: Decodable {
    let name: String
    let score: Int
    let isHitting: Bool
}

struct StatusBoard: Decodable {
    let base1st, base2nd, base3rd: Bool
    let strike, ball, out, inning: Int
    let isTop, isHitting: Bool
    
    enum CodingKeys: String, CodingKey {
        case base1st = "1stBase"
        case base2nd = "2ndBase"
        case base3rd = "3rdBase"
        case strike, ball, out, inning, isTop, isHitting
    }
}

struct PitckerOnMound: Decodable {
    let name: String
    let numOfThrowing: Int
}

struct BatterInBox: Decodable {
    let name: String
    let atBat: Int
    let numOfHitting: Int
}

struct RecordOfPitching: Decodable {
    let isStrike: Bool
    let numOfStrike: Int
    let numOfBall: Int
}
