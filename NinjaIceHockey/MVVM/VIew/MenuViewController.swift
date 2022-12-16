//
//  ViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol MenuViewControllerDelegate {
    func showPage(_ page: Page)
}

final class MenuViewController: UIViewController {

    private var tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    public var viewModel: MenuViewModel?
    public var coordinator: MainCoordinator?
    public var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchProductList()
    }
}

private extension MenuViewController {
    
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
            MenuTableViewCell.self,
            forCellReuseIdentifier: MenuTableViewCell.cellId
        )
        
        tableView.rx
            .setDelegate(SimpleTableViewDelegate(height: 40))
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Page.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showPage(item)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel?.items.bind(
            to: tableView.rx.items(
                cellIdentifier: MenuTableViewCell.cellId,
                cellType: MenuTableViewCell.self
            )
        ) {
            (row, item, cell) in cell.configure(with: item)
        } .disposed(by: disposeBag)
    }
}
