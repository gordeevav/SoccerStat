//
//  PlayerViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class PlayerViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let tableViewDelegate = SimpleTableViewDelegate(height: 70)
    
    public var viewModel: PlayerViewModel? {
        didSet {
            viewModelDidUpdated()
        }
    }
    
    private lazy var teamIconImageView = UIImageView() .. {
        view.addSubview($0)
        
        $0.contentMode = .scaleAspectFit
        $0.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    private lazy var teamNameLabel = UILabel() .. {
        view.addSubview($0)
        
        $0.font = $0.font.withSize(18)
        $0.textColor = .appWhite
        $0.textAlignment = .center
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(teamIconImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(30)
        }
    }
    
    private lazy var playerHeaderLabel = UILabel() .. {
        view.addSubview($0)
        
        $0.textColor = .appWhite
        $0.backgroundColor = .appOrange
        $0.textAlignment = .center
        $0.text = "Players"
                
        $0.snp.makeConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.right.equalTo(view)
            make.left.equalTo(view)
        }
    }
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.separatorColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(playerHeaderLabel.snp.bottom).offset(4)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        $0.register(
            PlayerTableViewCell.self,
            forCellReuseIdentifier: PlayerTableViewCell.cellId
        )

        $0.rx.setDelegate(tableViewDelegate).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBackground
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
