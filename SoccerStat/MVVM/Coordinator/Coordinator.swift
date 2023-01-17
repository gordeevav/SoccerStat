//
//  Coordinator.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

