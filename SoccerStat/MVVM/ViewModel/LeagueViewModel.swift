//
//  LeagueViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxSwift

final class LeagueViewModel {
    
    public let items = PublishSubject<[League]>()
    
    public func fetchProductList() {
        let result = [
            League(tournamentId: 17, seasonId: 41886, name: "English Premier League", logo: UIImage(named: "english")),
            League(tournamentId: 35, seasonId: 42268, name: "Bundesliga", logo: UIImage(named: "bundesliga")),
            League(tournamentId: 8, seasonId: 42409, name: "LaLiga", logo: UIImage(named: "laliga")),
            League(tournamentId: 23, seasonId: 42415, name: "Serie A Italy", logo: UIImage(named: "seriea")),
            League(tournamentId: 34, seasonId: 42273, name: "Ligue 1", logo: UIImage(named: "ligue1")),
            League(tournamentId: 325, seasonId: 40557, name: "Serie A Brazil", logo: UIImage(named: "brazil")),
            League(tournamentId: 37, seasonId: 42256, name: "Eredivise", logo: UIImage(named: "eredivisie")),
            League(tournamentId: 203, seasonId: 42388, name: "Russian Premier League", logo: UIImage(named: "rpl")),
        ]
        
        items.onNext(result)
        items.onCompleted()
    }
    
}
