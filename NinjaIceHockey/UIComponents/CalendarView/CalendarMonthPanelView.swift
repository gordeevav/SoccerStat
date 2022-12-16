//
//  CalendarMonthPanelView.swift
//  NinjaIceHockey
//
//  Created by Александр on 25.11.2022.
//

import UIKit
import SnapKit
import RxSwift

final class CalendarMonthPanelView: UIView {
    
    enum ButtonPress {
        case next
        case prev
    }
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .appWhite
        label.font = label.font.withSize(14)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        
        return button
    }()
    
    private lazy var prevMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        
        return button
    }()

    init() {
        super.init(frame: .zero)
        configureMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMe()
    }
}

extension CalendarMonthPanelView {
    
    func configureMe() {
        backgroundColor = .appOrange
        layer.cornerRadius = 15
        
        configureMonthLabel()
        configureNextMonthButton()
        configurePrevMonthButton()
    }
 
    func configureMonthLabel() {
        addSubview(monthLabel)
        
        monthLabel.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    func configureNextMonthButton() {
        addSubview(nextMonthButton)
        
        nextMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    func configurePrevMonthButton() {
        addSubview(prevMonthButton)
        
        prevMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}

