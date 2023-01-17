//
//  TeamTableViewCell.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import SnapKit

final class TeamTableViewCell: UITableViewCell {
    
    private lazy var logoImageView = UIImageView() .. {
        addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    private lazy var titleLabel = UILabel() .. {
        addSubview($0)
        
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    private lazy var arrowImageView = UIImageView() .. {
        addSubview($0)
        
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.white, .appOrange])
        $0.image = UIImage(systemName: "chevron.forward.square.fill", withConfiguration: configuration)

        $0.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    public func configure(with team: Team) {
        logoImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: team.id).url)
        titleLabel.text = team.name
    }
}
