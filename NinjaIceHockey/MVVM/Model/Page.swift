//
//  MenuItem.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import Foundation

enum Page: String, CaseIterable {
    case league = "League"
    case matches = "Matches"
    case transfer = "Transfers"
    case notes = "Notes"
    case calendar = "Calendar"
    case news = "News"
    case favourites = "Favourites"
    case shop = "Shop"
    case bet = "Bet"
    case myBet = "My Bet"
    case interactive = "Interactive"
    case feedback = "Feedback"
}

struct Season {
    let id: String
    let year: String
}

//struct MenuItem1 {
//    let id: Int
//    let tournamentId: Int
//    let seasonId: Int
//
//    let title: String
//    let seasons: [Season]
//
//    static let mock: [MenuItem1] = {[
//        MenuItem1(id: 1, tournamentId: 17, seasonId: <#T##Int#>, title: <#T##String#>, seasons: <#T##[Season]#>))
//    ]}()
//}
