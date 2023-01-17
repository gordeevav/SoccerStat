//
//  MatchesData.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import Foundation

struct MatchesData: Decodable {
    let tournaments: [TournamentData]?
}

struct TournamentData: Decodable {
    let events: [EventData]?
}

struct EventData: Decodable {
    let id: UInt?
    let homeTeam: MatchesTeamData?
    let awayTeam: MatchesTeamData?
    let startTimestamp: UInt?
}

struct MatchesTeamData: Decodable {
    let id: UInt?
    let name: String?
}
