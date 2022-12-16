//
//  Player.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

struct Player {
    let id: UInt
    let name: String
    let country: String
    let age: String
    let position: String
    let birthday: String
    let height: String
    
    let team: Team
    
    static func mock() -> Player {
        Player(id: 839956, name: "Jack Smith", country: "USA", age: "21", position: "Defender", birthday: "1990/12/01", height: "120/14", team: Team.mock())
    }
}
