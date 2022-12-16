//
//  MainCoordinator.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private let animated = true
    
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMenu()
        //showTest()
    }
    
    func showMenu() {
        let viewController = MenuViewController()
        viewController.coordinator = self
        viewController.delegate = self
        viewController.viewModel = MenuViewModel()
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showTest() {
//        showNote(NoteVM.mock())
    }
}

extension MainCoordinator: MenuViewControllerDelegate {
    func showPage(_ page: Page) {
        switch page {
        case .league:       showLeagues()
        case .matches:      showMatches()
        case .transfer:     showTransfers()
        case .notes:        showNotes()
        case .calendar:     showCalendar()
        case .news:         print(page)
        case .favourites:   print(page)
        case .shop:         print(page)
        case .bet:          print(page)
        case .myBet:        print(page)
        case .interactive:  print(page)
        case .feedback:     print(page)
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
    
    func showCalendar() {
        let viewController = CalendarViewController()
        viewController.title = "Calendar"
        
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

extension MainCoordinator: LeagueViewControllerDelegate {
    func showLeagueTeams(_ league: League) {
        let viewController = TeamViewController()
        viewController.viewModel = TeamViewModel(league: league)
        viewController.delegate = self
        viewController.title = "Teams"
                
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension MainCoordinator: TeamViewControllerDelegate {
    func showTeamPlayers(_ team: Team) {
        let viewController = PlayerViewController()
        viewController.viewModel = PlayerViewModel(team: team)
        viewController.title = "Players"
//        viewController.delegate = self
                
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension MainCoordinator: MatchesViewControllerDelegate {
    func showMatchHistory(for match: Match) {
        print("showMatchHistory", match)
    }
}

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

extension MainCoordinator: NoteViewControllerDelegate {
    func saveNoteDidPress() {
        navigationController.popViewController(animated: animated)
    }
    
    func cancelDidPress() {
        navigationController.popViewController(animated: animated)
    }
}
