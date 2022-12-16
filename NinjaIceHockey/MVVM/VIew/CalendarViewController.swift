//
//  CalendarViewController.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import UIKit
import SnapKit

final class CalendarViewController: UIViewController {

    let montPanel = CalendarMonthPanelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureMe()
        view.backgroundColor = .appBackground
        let calendarView = CalendarView()
//        view.addSubview(calendarView)
        view.addSubview(montPanel)
        
//        calendarView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.left.equalTo(view)
//            make.right.equalTo(view)
//            make.height.equalTo(view).multipliedBy(0.6)
//        }
        
        montPanel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.5)
            make.height.equalTo(30)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel?.fetchData(disposeBag: disposeBag)
    }
    
    
}


