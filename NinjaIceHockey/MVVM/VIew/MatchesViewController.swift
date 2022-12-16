//
//  MatchesViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol MatchesViewControllerDelegate {
    func showMatchHistory(for match: Match)
}

final class MatchesViewController: UIViewController {

    private var tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var matchObservable = PublishSubject<Match>()
    
    public var viewModel = MatchesViewModel()
    public var delegate: MatchesViewControllerDelegate?
    
    private let tableViewDelegate = SimpleTableViewDelegate(height: 190)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchProductList()
    }
}

private extension MatchesViewController {
    
    func configureMe() {
        configureMatchObservable()
        configureTableview()
        
        bindViewModel()
    }
    
    func configureMatchObservable() {
        matchObservable.subscribe(onNext: { [weak self] match in
            self?.delegate?.showMatchHistory(for: match)
        })
        .disposed(by: disposeBag)
    }
    
    func configureTableview() {
        view.addSubview(tableView)
        
        tableView.register(
            MatchesCellView.self,
            forCellReuseIdentifier: MatchesCellView.cellId
        )
        
        tableView.separatorColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        tableView.rx
            .setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: MatchesCellView.cellId,
                cellType: MatchesCellView.self
            )
        ) { [weak self] (row, item, cell) in
            guard let self = self else { return }
            cell.configure(with: item, matchObservable: self.matchObservable)
        }
        .disposed(by: disposeBag)
    }
}
