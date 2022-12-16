//
//  TransferViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

final class TransferViewController: UIViewController {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private let tableViewDelegate = SimpleTableViewDelegate(height: 150)
    
    public var viewModel: TransferViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData(disposeBag: disposeBag)
    }
}

private extension TransferViewController {
    
    func configureMe() {
        configureTableViewConstraints()
        configureTableViewCells()
        bindViewModel()
    }
    
    func configureTableViewConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    func configureTableViewCells() {
        tableView.allowsSelection = false
        
        tableView.register(
            TransferTableViewCell.self,
            forCellReuseIdentifier: TransferTableViewCell.cellId
        )
        
        tableView.rx
            .setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
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
