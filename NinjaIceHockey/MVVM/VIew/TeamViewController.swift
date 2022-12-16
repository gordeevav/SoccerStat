//
//  TeamViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol TeamViewControllerDelegate {
    func showTeamPlayers(_ team: Team)
}

class TeamViewController: UIViewController {

    private let leagueIconImageView = UIImageView()
    private let leagueNameLabel = UILabel()
    private let teamHeaderLabel = UILabel()
    
    private var tableView = UITableView()
    private let disposeBag = DisposeBag()
    private let tableViewDelegate = SimpleTableViewDelegate(height: 50)
    
    public var viewModel: TeamViewModel? {
        didSet { viewModelDidUpdated() }
    }

    public var delegate: TeamViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }
}

private extension TeamViewController {
    
    func configureMe() {
        view.backgroundColor = .appBackground
        
        configureLeagueViews()
        configureTableview()
    }
    
    func configureLeagueViews() {
        view.addSubview(leagueIconImageView)
        leagueIconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        view.addSubview(leagueNameLabel)
        leagueNameLabel.font = leagueNameLabel.font.withSize(18)
        leagueNameLabel.textColor = .appWhite
        leagueNameLabel.textAlignment = .center
        leagueNameLabel.snp.makeConstraints { make in
            make.top.equalTo(leagueIconImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(30)
        }
        
        view.addSubview(teamHeaderLabel)
        teamHeaderLabel.textColor = .appWhite
        teamHeaderLabel.backgroundColor = .appOrange
        teamHeaderLabel.textAlignment = .center
        teamHeaderLabel.text = "Team"
        teamHeaderLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(view)
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(30)
            make.left.equalTo(0)
        }
    }
    
    func configureTableview() {
        view.addSubview(tableView)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(
            TeamTableViewCell.self,
            forCellReuseIdentifier: TeamTableViewCell.cellId
        )
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(teamHeaderLabel.snp.bottom)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        tableView.rx
            .setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Team.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showTeamPlayers(item)
            })
            .disposed(by: disposeBag)
    }
    
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
