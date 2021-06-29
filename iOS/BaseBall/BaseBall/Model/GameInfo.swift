//
//  GameInfo.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

struct GameInfo: Decodable {
    let gameId, selectedTeamId: Int
    let homeTeam, awayTeam: TeamInfo
    let statusBoard: StatusBoard
    let recordOfPitching: [RecordOfPitching]
}

struct TeamInfo: Decodable {
    let teamId: Int
    let name: String
    let score: Int
    let occupied: Bool
}

struct StatusBoard: Decodable {
    let thirdBase, secondBase, firstBase, top: Bool
    let strike, ball, out, inning: Int
    let homeBase, hitting: Bool
    let pitcher: Pitcher
    let batter: Batter
}

struct Batter: Codable {
    let name: String
    let numOfBatting, numOfHitting: Int
    let imageUrl: String
}

struct Pitcher: Codable {
    let name: String
    let numOfThrowing: Int
    let imageUrl: String
}

struct RecordOfPitching: Codable {
    let recordId: Int
    let name, status: String
    let numOfStrike, numOfBall: Int
    let charactersOfPitchings: String
}
