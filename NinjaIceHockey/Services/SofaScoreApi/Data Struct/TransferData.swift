//
//  TransferData.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import Foundation

struct TransfersData: Decodable {
    let transfers: [TransferData]?
}

struct TransferData: Decodable {
    let player: TransferPlayerData?
    let fromTeamName: String?
    let toTeamName: String?
    let transferFeeRaw: TransferFeeRawData?
    let transferDateTimestamp: UInt?
    let transferFrom: TransferTeamData?
    let transferTo: TransferTeamData?
}

struct TransferTeamData: Decodable {
    let id: UInt?
}

struct TransferPlayerData: Decodable {
    let id: UInt?
    let name: String?
}

struct TransferFeeRawData: Decodable {
    let value: UInt?
    let currency: String?
}
