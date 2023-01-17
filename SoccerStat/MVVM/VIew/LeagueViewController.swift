//
//  LeagueViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

protocol LeagueViewControllerDelegate {
    func showTeams(league: League)
}

final class LeagueViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        $0.register(
            LeagueTableViewCell.self,
            forCellReuseIdentifier: LeagueTableViewCell.cellId
        )
        
        $0.rx.setDelegate(SimpleTableViewDelegate(height: 50)).disposed(by: disposeBag)
        
        $0.rx.modelSelected(League.self)
            .subscribe(onNext: { [weak self] league in
                self?.delegate?.showTeams(league: league)
            })
            .disposed(by: disposeBag)
    }
    
    public var viewModel: LeagueViewModel? {
        didSet {
            bindViewModel()
        }
    }
    public var delegate: LeagueViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchProductList()
    }
}

private extension LeagueViewController {
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
