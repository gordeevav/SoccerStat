//
//  Team.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

struct Team {
    let id: UInt
    let name: String
    
    let league: League
    
    static func mock() -> Team {
        Team(id: 1, name: "Team 1", league: League.mock())
    }
}
