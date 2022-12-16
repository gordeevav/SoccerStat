//
//  Match.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

struct Match {
    let id: UInt
    let team1: Team
    let team2: Team
    let date: String
    
    static func mock() -> Match {
        Match(
            id: 1,
            team1: Team(id: 1, name: "The Fox", league: League.mock()),
            team2: Team(id: 2, name: "Golilla", league: League.mock()),
            date: "27.20.2022"
        )
    }
}
