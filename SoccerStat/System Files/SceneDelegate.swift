//
//  SceneDelegate.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    private lazy var navigationController = UINavigationController() .. {
        $0.modalPresentationStyle = .fullScreen
        $0.view.backgroundColor = .appBackground
        
        let offset = UIOffset(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        $0.navigationBar.standardAppearance.titlePositionAdjustment = offset
        $0.navigationBar.scrollEdgeAppearance?.titlePositionAdjustment = offset
        $0.navigationBar.compactAppearance?.titlePositionAdjustment = offset

        $0.navigationBar.backgroundColor = .appOrange
        
        $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
        $0.navigationBar.shadowImage = UIImage()
        $0.navigationBar.tintColor = .appBlack
    }
    
    func configureApperance() {
        UITableViewCell.appearance().selectedBackgroundView = UIView() .. {
            $0.backgroundColor = .appOrange
        }
        UITableViewCell.appearance().backgroundColor = .appBackground
        
        UITableView.appearance().separatorColor = .appTableSeparatorColor
        UITableView.appearance().backgroundColor = .appBackground
        UITableView.appearance().separatorInset = .zero                
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configureApperance()
        
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

