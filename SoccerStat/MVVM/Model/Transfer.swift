//
//  Transfer.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 24.11.2022.
//

import Foundation

struct Transfer {
    let playerId: UInt
    let playerName: String
    let teamFromName: String
    let teamFromId: UInt
    let teamToName: String
    let teamToId: UInt
    let fee: String
    let date: String
}

extension Transfer {
    static func mock() -> Transfer {
        Transfer(playerId: 0, playerName: "", teamFromName: "", teamFromId: 1, teamToName: "", teamToId: 2, fee: "", date: "")
    }
}
