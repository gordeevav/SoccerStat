//
//  ViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol MenuViewControllerDelegate {
    func showPage(_ page: Page)
}

final class MenuViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    public var coordinator: MainCoordinator?
    public var delegate: MenuViewControllerDelegate?
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        $0.register(MenuTableViewCell.self,
            forCellReuseIdentifier: MenuTableViewCell.cellId
        )
        
        $0.rx.setDelegate(SimpleTableViewDelegate(height: 40))
            .disposed(by: disposeBag)
        
        $0.rx.modelSelected(Page.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showPage(item)
            })
            .disposed(by: disposeBag)
    }
    
    public var viewModel: MenuViewModel? {
        didSet {
            viewModel?.items.bind(
                to: tableView.rx.items(
                    cellIdentifier: MenuTableViewCell.cellId,
                    cellType: MenuTableViewCell.self
                )
            ) { (row, item, cell) in
                cell.configure(with: item)
            } .disposed(by: disposeBag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchProductList()
    }
}
