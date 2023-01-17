//
//  TeamViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

protocol TeamViewControllerDelegate {
    func showPlayers(team: Team)
}

final class TeamViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let tableViewDelegate = SimpleTableViewDelegate(height: 50)
    
    private lazy var leagueIconImageView = UIImageView() .. {
        view.addSubview($0)
        
        $0.contentMode = .scaleAspectFit
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    private lazy var leagueNameLabel = UILabel() .. {
        view.addSubview($0)
        $0.font = $0.font.withSize(18)
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.snp.makeConstraints { make in
            make.top.equalTo(leagueIconImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(30)
        }
    }
    
    private lazy var teamHeaderLabel = UILabel() .. {
        view.addSubview($0)
        $0.textColor = .appWhite
        $0.backgroundColor = .appOrange
        $0.textAlignment = .center
        $0.text = "Team"
        $0.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(view)
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(30)
            make.left.equalTo(0)
        }
    }
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        
        $0.register(TeamTableViewCell.self,
            forCellReuseIdentifier: TeamTableViewCell.cellId
        )
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(teamHeaderLabel.snp.bottom)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        $0.rx.setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
        
        $0.rx.modelSelected(Team.self)
            .subscribe(onNext: { [weak self] team in
                self?.delegate?.showPlayers(team: team)
            })
            .disposed(by: disposeBag)
    }
    
    public var viewModel: TeamViewModel? {
        didSet {
            viewModelDidUpdated()
        }
    }

    public var delegate: TeamViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBackground
    }
}

private extension TeamViewController {
    
    func viewModelDidUpdated() {
        updateLeagueIconAndLabel()
        bindViewModel()
    }
    
    func updateLeagueIconAndLabel() {
        leagueNameLabel.text = viewModel?.league.name
        leagueIconImageView.image = viewModel?.league.logo
    }
    
    func bindViewModel() {
        viewModel?.items.bind(
            to: tableView.rx.items(
                cellIdentifier: TeamTableViewCell.cellId,
                cellType: TeamTableViewCell.self
            )
        ) { (row, item, cell) in
            cell.configure(with: item)
        }.disposed(by: disposeBag)
        
        viewModel?.fetchData(disposeBag: disposeBag)
    }
}
