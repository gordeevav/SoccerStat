//
//  Coordinator.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

//class CoordinatorViewController: UIViewController {
//    var coordinator: Coordinator?
//}

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

