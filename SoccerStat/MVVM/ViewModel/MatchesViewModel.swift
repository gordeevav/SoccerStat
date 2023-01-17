//
//  MatchesViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import RxSwift

final class MatchesViewModel {
    private let api = SofaScoreApi()
    private let disposeBag = DisposeBag()
    private let dateFormatter = DateFormatter()
    
    public let items = PublishSubject<[Match]>()
    
    public func fetchProductList() {
        api.matches(tournamentId: 8, seasonId: 42409)
            .compactMap { [weak self] matchesData -> [Match]? in
                self?.getMatchArray(from: matchesData)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
    
    private func getMatchArray(from matchesData: MatchesData) -> [Match]? {
        guard let events = matchesData.tournaments?[0].events
        else { return nil }
        
        let result: [Match] = events.compactMap { eventData in
            guard
                let team1 = eventData.homeTeam,
                let team1Id = team1.id,
                let team1Name = team1.name,
                
                let team2 = eventData.awayTeam,
                let team2Id = team2.id,
                let team2Name = team2.name,
                
                let startTimestamp = eventData.startTimestamp,
                let id = eventData.id
            else {
                return nil
            }
            
            return Match(
                id: id,
                team1: Team(id: team1Id, name: team1Name, league: League.mock()),
                team2: Team(id: team2Id, name: team2Name, league: League.mock()),
                date: dateFormatter.format(from: startTimestamp, dateFormat: "dd.MM.YYYY")
            )
        }
        
        return result
    }
}
