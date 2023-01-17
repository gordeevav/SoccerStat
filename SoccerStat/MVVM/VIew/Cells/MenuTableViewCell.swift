//
//  MenuTableViewCell.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import SnapKit

final class MenuTableViewCell: UITableViewCell {

    private lazy var titleLabel = UILabel() .. {
        addSubview($0)
        
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    public func configure(with menuItem: Page) {
        titleLabel.text = menuItem.rawValue
    }
}
