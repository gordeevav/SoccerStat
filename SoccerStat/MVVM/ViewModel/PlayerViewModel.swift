//
//  PlayerViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import RxSwift

final class PlayerViewModel {
    
    private let api = SofaScoreApi()
    private let emptyString = "-/-"
    private let dateFormatter = DateFormatter()
    private var players = [Player]()
    
    public let team: Team
    public let items = PublishSubject<[Player]>()
    
    init(team: Team) {
        self.team = team
    }
    
    public func fetchData(disposeBag: DisposeBag) {
        players.removeAll()
        
        let league = team.league
        api.seasonPlayers(tournamentId: league.tournamentId, seasonId: league.seasonId)
            .subscribe(onNext: { [weak self] seasonPlayersDataArray in
                guard
                    let seasonPlayersData = seasonPlayersDataArray.first(where: {
                        $0.name == "Average rating"
                    }),
                    let playerIds = self?.getPlayerIds(from: seasonPlayersData)
                else { return }

                self?.fetchPlayers(playerIds: playerIds, disposeBag: disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
 
private extension PlayerViewModel {
    
    func fetchPlayers(playerIds: [UInt], disposeBag: DisposeBag) {
        playerIds.forEach { playerId in
            fetchPlayer(playerId: playerId, disposeBag: disposeBag)
        }
    }
    
    func fetchPlayer(playerId: UInt, disposeBag: DisposeBag) {
        api.player(playerId: playerId)
            .subscribe(onNext: { [weak self] playerWrapperData in
                guard
                    let self = self,
                    let playerData = playerWrapperData.player
                else { return }

                self.onNextPlayer(from: playerData)
            })
            .disposed(by: disposeBag)
    }
    
    func onNextPlayer(from playerData: PlayerData) {
        let player = getPlayer(from: playerData)
        players.append(player)
        
        items.onNext(players)
    }
}

private extension PlayerViewModel {
    
    func getPlayer(from playerData: PlayerData) -> Player {
        Player(
            id:         playerData.id ?? 0,
            name:       playerData.name ?? self.emptyString,
            country:    playerData.country?.name ?? emptyString,
            age:        getPlayerAge(from: playerData.dateOfBirthTimestamp) ?? emptyString,
            position:   playerData.position ?? emptyString,
            birthday:   getPlayerBirthday(from: playerData.dateOfBirthTimestamp) ?? emptyString,
            height:     String(playerData.height ?? 0),
            team:       team
        )
    }
    
    func getPlayerAge(from timestamp: UInt?) -> String? {
        guard let timestamp = timestamp else { return emptyString }
        
        let now = Date()
        let birthday = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        
        return String(ageComponents.year!)
    }
    
    func getPlayerBirthday(from timestamp: UInt?) -> String? {
        guard let timestamp = timestamp else { return emptyString }
        return dateFormatter.format(from: timestamp, dateFormat: "dd.MM.YYYY")
    }
    
    func getPlayerIds(from playersData: SeasonPlayersData) -> [UInt]? {
        guard let topPlayersData = playersData.topPlayers
        else { return nil }
            
        let result: [UInt] = topPlayersData.compactMap { playerWithMatch in
            guard
                let player = playerWithMatch.player,
                let id = player.id
            else { return nil }

            return id
        }
        
        return result
    }
    
}
