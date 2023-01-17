//
//  PlayerCell.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import SnapKit

final class PlayerTableViewCell: UITableViewCell {

    private static let labelsFontSize: CGFloat = 12
    private static let labelsCenterYOffset = 10
    private static let substratePadding: CGFloat = 6
    
    private lazy var substrateView = UIView() .. {
        addSubview($0)
        
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.orange.cgColor
        $0.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Self.substratePadding)
            make.bottom.equalTo(self).offset(-Self.substratePadding)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    private lazy var photoImageView = UIImageView() .. {
        substrateView.addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(substrateView).offset(10)
            make.centerY.equalTo(substrateView)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    private lazy var nameLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(10)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
            make.right.equalTo(ageLabel.snp.left)
        }
    }
    
    private lazy var countryLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(10)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
            make.right.equalTo(ageLabel.snp.left)
        }
    }
    
    private lazy var ageLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(substrateView.snp.centerX)
            make.width.equalTo(substrateView.snp.width).multipliedBy(0.2)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    private lazy var positionLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(substrateView.snp.centerX)
            make.width.equalTo(substrateView.snp.width).multipliedBy(0.2)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    private lazy var birthdayLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(ageLabel.snp.right).offset(3)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    private lazy var staticticsLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
        $0.snp.makeConstraints { make in
            make.left.equalTo(ageLabel.snp.right).offset(3)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    public func configure(with player: Player) {        
        nameLabel.text = player.name
        countryLabel.text = player.country
        ageLabel.text = player.age
        positionLabel.text = player.position
        birthdayLabel.text = player.birthday
        staticticsLabel.text = player.height
        photoImageView.kf.setImage(with: SofaScoreApiEndpoint.playerImage(playerId: player.id).url)
    }
    
    private func initUI() {
        selectedBackgroundView = UIView() .. {
            $0.backgroundColor = .clear
        }        
    }
}
