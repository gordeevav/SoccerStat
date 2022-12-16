//
//  PlayersData.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import Foundation

struct SeasonPlayersData: Decodable {
    let name: String?
    let topPlayers: [SeasonPlayerWithMatchData]?
}

struct SeasonPlayerWithMatchData: Decodable {
    let player: SeasonPlayerData?
}

struct SeasonPlayerData: Decodable {
    let id: UInt?
}

// ----

struct PlayerWrapperData: Decodable {
    let player: PlayerData?
}

struct PlayerCountryData: Decodable {
    let name: String
}

struct PlayerData: Decodable {
    let id: UInt?
    let name: String?
    let dateOfBirthTimestamp: UInt?
    let position: String?
    let height: Int?
    let country: PlayerCountryData?
}
