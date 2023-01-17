//
//  ApiEndpoint.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import Foundation

// MARK: ApiError
enum ApiError: Error {
}

// MARK: ApiEndpoint
enum SofaScoreApiEndpoint {
    // team
    case teams(tournamentId: UInt, seasonId: UInt)
    case teamInfo(teamId: UInt)
    case teamImage(teamId: UInt)
    
    // players
    case players(tournamentId: UInt, seasonId: UInt)
    case playerInfo(playerId: UInt)
    case playerImage(playerId: UInt)
    
    // matches
    case matches(tournamentId: UInt, seasonId: UInt)
    
    // transffer
    case transfers
}

extension SofaScoreApiEndpoint {
    private var baseUrl: String { "https://api.sofascore.com/" }
    
    public var path: String {
        switch self {
        // team
        case .teams(let tournamentId, let seasonId):
            return baseUrl + "api/v1/unique-tournament/\(tournamentId)/season/\(seasonId)/top-teams/overall"
        case .teamInfo(let teamId):
            return baseUrl + "api/v1/team/\(teamId)"
        case .teamImage(let teamId):
            return baseUrl + "api/v1/team/\(teamId)/image"
            
        // players
        case .players(let tournamentId, let seasonId):
            return baseUrl + "mobile/v4/unique-tournament/\(tournamentId)/season/\(seasonId)/top-players"
        case .playerInfo(let playerId):
            return baseUrl + "api/v1/player/\(playerId)"
        case .playerImage(let playerId):
            return baseUrl + "api/v1/player/\(playerId)/image"
            
        // matches
        case .matches(let tournamentId, let seasonId):
            return baseUrl + "mobile/v4/unique-tournament/\(tournamentId)/season/\(seasonId)/events"
            
        // transfer
        case .transfers:
            return baseUrl + "api/v1/transfer"
        }
    }
    
    public var url: URL? { URL(string: self.path) }
}
