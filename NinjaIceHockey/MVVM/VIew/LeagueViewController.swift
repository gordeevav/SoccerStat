//
//  LeagueViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol LeagueViewControllerDelegate {
    func showLeagueTeams(_ league: League)
}

final class LeagueViewController: UIViewController {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    public var viewModel: LeagueViewModel?
    public var delegate: LeagueViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchProductList()
    }
}

private extension LeagueViewController {
    
    func configureMe() {
        configureTableViewConstraints()
        configureTableViewCells()
        bindViewModel()
    }
    
    func configureTableViewConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    func configureTableViewCells() {
        tableView.register(
            LeagueTableViewCell.self,
            forCellReuseIdentifier: LeagueTableViewCell.cellId
        )
        
        tableView.rx
            .setDelegate(SimpleTableViewDelegate(height: 50))
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(League.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showLeagueTeams(item)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel?.items.bind(
            to: tableView.rx.items(
                cellIdentifier: LeagueTableViewCell.cellId,
                cellType: LeagueTableViewCell.self
            )
        ) { (row, item, cell) in
            cell.configure(with: item, indexNumber: row + 1)
        }.disposed(by: disposeBag)
    }
}
