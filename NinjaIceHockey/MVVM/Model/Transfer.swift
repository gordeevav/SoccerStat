//
//  Transfer.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
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
    
    static func mock() -> Transfer {
        Transfer(playerId: 0, playerName: "", teamFromName: "", teamFromId: 1, teamToName: "", teamToId: 2, fee: "", date: "")
    }
}
