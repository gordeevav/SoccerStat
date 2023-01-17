//
//  Team.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import Foundation

struct Team {
    let id: UInt
    let name: String
    
    let league: League
}

extension Team {
    static func mock() -> Team {
        Team(id: 1, name: "Team 1", league: League.mock())
    }
}
