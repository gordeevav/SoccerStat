//
//  TransferViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 24.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class TransferViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let tableViewDelegate = SimpleTableViewDelegate(height: 150)
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        $0.allowsSelection = false
        $0.register(TransferTableViewCell.self,
            forCellReuseIdentifier: TransferTableViewCell.cellId
        )
        $0.rx.setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
    }

    public var viewModel: TransferViewModel? {
        didSet {
            viewModel?.items.bind(
                to: tableView.rx.items(
                    cellIdentifier: TransferTableViewCell.cellId,
                    cellType: TransferTableViewCell.self
                )
            ) { (row, item, cell) in
                cell.configure(with: item)
            }.disposed(by: disposeBag)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData(disposeBag: disposeBag)
    }
}
