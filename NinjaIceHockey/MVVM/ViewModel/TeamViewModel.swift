//
//  TeamViewModel.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import Foundation
import RxSwift

final class TeamViewModel {
    
    private let api = SofaScoreApi()
    
    public let items = PublishSubject<[Team]>()
    public let league: League
    
    init(league: League) {
        self.league = league
    }
    
    public func fetchData(disposeBag: DisposeBag) {
        api.teams(tournamentId: league.tournamentId, seasonId: league.seasonId)
            .compactMap { [weak self] teamsData -> [Team]? in
                self?.getTeamArray(from: teamsData)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
    
    private func getTeamArray(from teamsData: TeamsData) -> [Team]? {
        guard let teamsAndStatisticsDataArray = teamsData.topTeams?.avgRating
        else { return nil }
            
        let result: [Team] = teamsAndStatisticsDataArray.compactMap { teamData in
            guard
                let team = teamData.team,
                let id = team.id,
                let name = team.name
            else { return nil }

            return Team(id: id, name: name, league: self.league)
        }
        
        return result
    }
}
