//
//  Api.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import RxSwift
import RxAlamofire

final class SofaScoreApi {
    
    private let disposeBag = DisposeBag()
    
    public func teams(tournamentId: UInt, seasonId: UInt) -> Observable<TeamsData> {
        RxAlamofire.requestDecodable(.get,
            SofaScoreApiEndpoint.teams(tournamentId: tournamentId, seasonId: seasonId).path
        ).compactMap { $1 }
    }
    
    public func matches(tournamentId: UInt, seasonId: UInt) -> Observable<MatchesData> {
        return RxAlamofire.requestDecodable(.get,
            SofaScoreApiEndpoint.matches(tournamentId: tournamentId, seasonId: seasonId).path
        ).compactMap { $1 }
    }
    
    public func seasonPlayers(tournamentId: UInt, seasonId: UInt) -> Observable<[SeasonPlayersData]> {
        return RxAlamofire.requestDecodable(.get,
            SofaScoreApiEndpoint.players(tournamentId: tournamentId, seasonId: seasonId).path
        ).compactMap { $1 }
    }
    
    public func player(playerId: UInt) -> Observable<PlayerWrapperData> {
        return RxAlamofire.requestDecodable(.get,
            SofaScoreApiEndpoint.playerInfo(playerId: playerId).path
        ).compactMap { $1 }
    }
    
    public func transfers() -> Observable<TransfersData> {
        return RxAlamofire.requestDecodable(.get,
            SofaScoreApiEndpoint.transfers.path
        ).compactMap { $1 }
    }
}
