//
//  LeagueTableViewCell.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit

final class LeagueTableViewCell: UITableViewCell {

    private lazy var indexNumberLabel = UILabel() .. {
        addSubview($0)
        
        $0.textColor = .appWhite
        $0.backgroundColor = .appOrange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
        $0.textAlignment = .center
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    private lazy var iconImageView = UIImageView() .. {
        addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(indexNumberLabel.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    private lazy var titleLabel = UILabel() .. {
        addSubview($0)
        
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    public func configure(with league: League, indexNumber: Int) {
        titleLabel.text = league.name
        iconImageView.image = league.logo
        indexNumberLabel.text = String(indexNumber)
    }
}
