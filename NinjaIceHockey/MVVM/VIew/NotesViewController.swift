//
//  NotesViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 25.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

protocol NotesViewControllerDelegate {
    func createNote()
    func showNote(_ note: Note)
}

final class NotesViewController: UIViewController {
    
    private static let plusButtonDiameter: CGFloat = 55

    private let tableViewDelegate = SimpleTableViewDelegate(height: 70)
    private let disposeBag = DisposeBag()
    
    private lazy var tableView = UITableView() .. { 
        view.addSubview($0)
        
        let cellClass = NotesTableViewCell.self
        
        $0.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(cellClass, forCellReuseIdentifier: cellClass.cellId)
        
        $0.rx.setDelegate(tableViewDelegate)
            .disposed(by: disposeBag)
        
        $0.rx.modelSelected(Note.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showNote(item)
            })
            .disposed(by: disposeBag)
        
        $0.rx.itemDeleted
            .subscribe { [weak self] indexPath in
                self?.viewModel?.deleteNote(index: indexPath.row)
            }
            .disposed(by: disposeBag)
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
    }
    
    private lazy var plusButton = UIButton() .. {
        view.addSubview($0)
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 4
        configuration.imagePlacement = .all
        configuration.image = UIImage(systemName: "plus")
        configuration.background.cornerRadius = Self.plusButtonDiameter / 2
        configuration.background.backgroundColor = .appOrange
        configuration.baseForegroundColor = .appWhite
        
        $0.configuration = configuration
        $0.rx.tap.bind { [weak self] in self?.delegate?.createNote() }
            .disposed(by: disposeBag)
        
        $0.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
            make.width.equalTo(Self.plusButtonDiameter)
            make.height.equalTo(Self.plusButtonDiameter)
        }
    }
    
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Note>>(
        configureCell: { _, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotesTableViewCell.cellId,
                for: indexPath
            ) as? NotesTableViewCell
            else { return UITableViewCell() }
            
            cell.configure(with: item)
            
            return cell
        },
        canEditRowAtIndexPath: { _, _ in true }
    )
    
    public var viewModel: NotesViewModel? { didSet { bindViewModel() } }
    public var delegate: NotesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchData),
            name: NSNotification.Name.NSManagedObjectContextDidSave,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func bindViewModel() {
//        viewModel?.items.bind(
//            to: tableView.rx.items(
//                cellIdentifier: NotesTableViewCell.cellId,
//                cellType: NotesTableViewCell.self
//            )
//        ) { (row, item, cell) in cell.configure(with: item) }
//        .disposed(by: disposeBag)
        
        viewModel?.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    @objc
    private func fetchData() {
        viewModel?.fetchData()
    }
}
