//
//  SceneDelegate.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        navigationController.modalPresentationStyle = .fullScreen
        
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .left
        
//        let label = UILabel()
//        label.text = "Title Label"
//        label.textAlignment = .left
//        navigationController.navigationItem.titleView = label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
//        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
//        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
//        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
        
        let offset = UIOffset(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        navigationController.navigationBar.standardAppearance.titlePositionAdjustment = offset
        navigationController.navigationBar.scrollEdgeAppearance?.titlePositionAdjustment = offset
        navigationController.navigationBar.compactAppearance?.titlePositionAdjustment = offset
//        navigationItem.largeTitleDisplayMode = .always
        
        
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.appBlack,
//            .paragraphStyle: paragraphStyle
        ]
        
        navigationController.navigationBar.backgroundColor = .appOrange
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = .appBlack
        navigationController.view.backgroundColor = .appBackground
        
        return navigationController
    }()
    
    func configureApperance() {
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.appOrange
        UITableViewCell.appearance().selectedBackgroundView = backgroundColorView
        UITableViewCell.appearance().backgroundColor = .appBackground
        
        UITableView.appearance().separatorColor = .appTableSeparatorColor
        UITableView.appearance().backgroundColor = .appBackground
        UITableView.appearance().separatorInset = .zero                
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        configureApperance()
        
//        let viewController = TeamViewController()
//        viewController.viewModel = TeamViewModel(league: League(indexNumber: 1, logo: nil, name: "League1"))
    
        
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

