//
//  TeamNetwork.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import Foundation

struct TeamsData: Decodable {
    let topTeams: TopTeamsData?
}

struct TopTeamsData: Decodable {
    let avgRating: [TeamsAndStatisticsData]?
}

struct TeamsAndStatisticsData: Decodable {
    let team: TeamData?
    let statistics: StatisticsData?
}

struct TeamData: Decodable {
    let name: String?
    let shortName: String?
    let id: UInt?
}

struct StatisticsData: Decodable {
    let avgRating: Double?
    let id: UInt?
    let matches: Int?
    let awardedMatches: Int?
}






