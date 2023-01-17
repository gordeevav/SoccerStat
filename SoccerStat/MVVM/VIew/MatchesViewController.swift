//
//  MatchesViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

protocol MatchesViewControllerDelegate {
    func showMatchHistory(for match: Match)
}

final class MatchesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var matchObservable = PublishSubject<Match>()
    
    private let tableViewDelegate = SimpleTableViewDelegate(height: 130)
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.separatorColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelection = false
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        $0.register(
            MatchesCellView.self,
            forCellReuseIdentifier: MatchesCellView.cellId
        )
        
        $0.rx.setDelegate(tableViewDelegate).disposed(by: disposeBag)
    }
    
    public var viewModel = MatchesViewModel()
    public var delegate: MatchesViewControllerDelegate?
    
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
        
        bindViewModel()
    }
    
    func configureMatchObservable() {
        matchObservable.subscribe(onNext: { [weak self] match in
            self?.delegate?.showMatchHistory(for: match)
        })
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
