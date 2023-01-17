//
//  League.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import UIKit

struct League {
    let tournamentId: UInt
    let seasonId: UInt
    
    let name: String
    let logo: UIImage?
}

extension League {
    static func mock() -> League {
        League(tournamentId: 10, seasonId: 20, name: "League Mock", logo: nil)
    }
}
