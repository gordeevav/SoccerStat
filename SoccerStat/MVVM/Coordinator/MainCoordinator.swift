//
//  MainCoordinator.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private let animated = true
    
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        showMenu()
    }
    
    public func showMenu() {
        let viewController = MenuViewController()
        viewController.coordinator = self
        viewController.delegate = self
        viewController.viewModel = MenuViewModel()
        
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - Main Menu
extension MainCoordinator: MenuViewControllerDelegate {
    func showPage(_ page: Page) {
        switch page {
        case .league:       showLeagues()
        case .matches:      showMatches()
        case .transfer:     showTransfers()
        case .notes:        showNotes()
        case .calendar:     return
        case .news:         return
        case .favourites:   return
        case .shop:         return
        case .bet:          return
        case .myBet:        return
        case .interactive:  return
        case .feedback:     return
        }
    }
    
    func showLeagues() {
        let viewController = LeagueViewController()
        viewController.viewModel = LeagueViewModel()
        viewController.delegate = self
        viewController.title = "Leagues"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showMatches() {
        let viewController = MatchesViewController()
        viewController.viewModel = MatchesViewModel()
        viewController.delegate = self
        viewController.title = "Matches"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showTransfers() {
        let viewController = TransferViewController()
        viewController.viewModel = TransferViewModel()
        viewController.title = "Transfers"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showNotes() {
        let viewController = NotesViewController()
        viewController.title = "Notes"
        viewController.viewModel = NotesViewModel()
        viewController.delegate = self
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Lague
extension MainCoordinator: LeagueViewControllerDelegate {
    func showTeams(league: League) {
        let viewController = TeamViewController()
        viewController.viewModel = TeamViewModel(league: league)
        viewController.delegate = self
        viewController.title = "Teams"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Team
extension MainCoordinator: TeamViewControllerDelegate {
    func showPlayers(team: Team) {
        let viewController = PlayerViewController()
        viewController.viewModel = PlayerViewModel(team: team)
        viewController.title = "Players"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Matches
extension MainCoordinator: MatchesViewControllerDelegate {
    func showMatchHistory(for match: Match) {
        print("showMatchHistory", match)
    }
}

// MARK: - Notes
extension MainCoordinator: NotesViewControllerDelegate {
    func createNote() {
        let viewController = NoteViewController()
        viewController.viewModel = NoteViewModel(note: nil)
        viewController.title = "Create a note"
        viewController.delegate = self
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showNote(_ note: Note) {
        let viewController = NoteViewController()
        viewController.viewModel = NoteViewModel(note: note)
        viewController.title = "Write a note"
        viewController.delegate = self
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Note
extension MainCoordinator: NoteViewControllerDelegate {
    func saveNoteDidPress() {
        navigationController.popViewController(animated: animated)
    }
    
    func cancelDidPress() {
        navigationController.popViewController(animated: animated)
    }
}
