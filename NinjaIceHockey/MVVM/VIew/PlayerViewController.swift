//
//  PlayerViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

//protocol PlayerViewControllerDelegate {
//    func showPlayer(_ player: Player)
//}

final class PlayerViewController: UIViewController {

    private let teamIconImageView = UIImageView()
    private let teamNameLabel = UILabel() .. {
        $0.font = $0.font.withSize(18)
        $0.textColor = .appWhite
        $0.textAlignment = .center
    }
    
    private let playerHeaderLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.backgroundColor = .appOrange
        $0.textAlignment = .center
        $0.text = "Players"
    }
    
    private var tableView = UITableView() .. {
        $0.separatorColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let disposeBag = DisposeBag()
    
    private let tableViewDelegate = SimpleTableViewDelegate(height: 70)
    
    public var viewModel: PlayerViewModel? {
        didSet { viewModelDidUpdated() }
    }
    
    //public var delegate: PlayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData(disposeBag: disposeBag)
    }
}

private extension PlayerViewController {
    func viewModelDidUpdated() {
        updateLeagueIconAndLabel()
        bindViewModel()
    }
    
    func updateLeagueIconAndLabel() {
        teamNameLabel.text = viewModel?.team.name
        if let teamId = viewModel?.team.id {
            teamIconImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: teamId).url)
        }
    }
    
    func bindViewModel() {
        viewModel?.items.bind(
            to: tableView.rx.items(
                cellIdentifier: PlayerTableViewCell.cellId,
                cellType: PlayerTableViewCell.self
            )
        ) { (row, item, cell) in
            cell.configure(with: item)
        }.disposed(by: disposeBag)
    }
}

private extension PlayerViewController {
    
    func configureMe() {
        view.backgroundColor = .appBackground
        
        configureTeamIconView()
        configureTeamNameLabel()
        configurePlayersHeaderLabel()
        
        configureTableViewCells()
        configureTableViewConstraints()
    }
    
    func configureTeamIconView() {
        view.addSubview(teamIconImageView)
        
        teamIconImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func configureTeamNameLabel() {
        view.addSubview(teamNameLabel)
        
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamIconImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(30)
        }
    }
    
    func configurePlayersHeaderLabel() {
        view.addSubview(playerHeaderLabel)
                
        playerHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.right.equalTo(view)
            make.left.equalTo(view)
        }
    }
    
    func configureTableViewConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(playerHeaderLabel.snp.bottom).offset(4)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
    }
    
    func configureTableViewCells() {
        tableView.register(
            PlayerTableViewCell.self,
            forCellReuseIdentifier: PlayerTableViewCell.cellId
        )

        tableView.rx
            .setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
    }
}
