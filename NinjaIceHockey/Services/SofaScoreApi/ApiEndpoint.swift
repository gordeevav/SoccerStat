//
//  ApiEndpoint.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import Foundation

import Foundation
import UIKit

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
    var baseUrl: String { "https://api.sofascore.com/" }
    
    var path: String {
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
            return mobileV4(tournamentId: tournamentId, seasonId: seasonId) + "top-players"
        case .playerInfo(let playerId):
            return baseUrl + "api/v1/player/\(playerId)"
        case .playerImage(let playerId):
            return baseUrl + "api/v1/player/\(playerId)/image"
            
        // matches
        case .matches(let tournamentId, let seasonId):
            return mobileV4(tournamentId: tournamentId, seasonId: seasonId) + "events"
            
        // transfer
        case .transfers:
            return baseUrl + "api/v1/transfer"
        }
        
    }
    
    var url: URL? { URL(string: self.path) }
    
    private func mobileV4(tournamentId: UInt, seasonId: UInt) -> String {
        baseUrl + "mobile/v4/unique-tournament/\(tournamentId)/season/\(seasonId)/"
    }

//    var request: URLRequest {
//        let url = URL(string: path)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        return request
//    }
    
//    var emptyDataError: ApiError {
//        switch self {
//        case .rockets: return .emptyRocketData
//        case .launches: return .emptyLaunchesData
//        case .image: return .emptyImageData
//        }
//    }
}
