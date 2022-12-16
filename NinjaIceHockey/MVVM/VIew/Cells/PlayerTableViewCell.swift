//
//  PlayerCell.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import Kingfisher

final class PlayerTableViewCell: UITableViewCell {

    private static let labelsFontSize: CGFloat = 12
    private static let labelsCenterYOffset = 10
    private static let substratePadding: CGFloat = 6
    
    private lazy var substrateView = UIView() .. {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.orange.cgColor
    }
    
    private lazy var photoImageView = UIImageView()
    
    private lazy var nameLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(Self.labelsFontSize)
    }
    
    private lazy var countryLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(Self.labelsFontSize)
    }
    
    private lazy var ageLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
    }
    
    private lazy var positionLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
    }
    
    private lazy var birthdayLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
    }
    private lazy var staticticsLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.font = $0.font.withSize(Self.labelsFontSize)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMe()
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
}

private extension PlayerTableViewCell {
    
    func configureMe() {
        configureCell()
        
        configureSubstrate()
        configurePhotoImageView()
        
        configureAgeLabel()
        configurePositionLabel()
        
        configureNameLabel()
        configureCountryLabel()
        
        configureBirthdayLabel()
        configureStatisticsLabel()
    }
    
    func configureCell() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
    }
    
    func configureSubstrate() {
        addSubview(substrateView)
        substrateView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Self.substratePadding)
            make.bottom.equalTo(self).offset(-Self.substratePadding)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    func configurePhotoImageView() {
        substrateView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.left.equalTo(substrateView).offset(10)
            make.centerY.equalTo(substrateView)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    func configureNameLabel() {
        substrateView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(10)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
            make.right.equalTo(ageLabel.snp.left)
        }
    }
    
    func configureCountryLabel() {
        substrateView.addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(10)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
            make.right.equalTo(ageLabel.snp.left)
        }
    }
    
    func configureAgeLabel() {
        substrateView.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { make in
            make.left.equalTo(substrateView.snp.centerX)
            make.width.equalTo(substrateView.snp.width).multipliedBy(0.25)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    func configurePositionLabel() {
        substrateView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { make in
            make.left.equalTo(substrateView.snp.centerX)
            make.width.equalTo(substrateView.snp.width).multipliedBy(0.25)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    func configureBirthdayLabel() {
        substrateView.addSubview(birthdayLabel)
        birthdayLabel.snp.makeConstraints { make in
            make.left.equalTo(ageLabel.snp.right).offset(3)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(substrateView).offset(-Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
    func configureStatisticsLabel() {
        substrateView.addSubview(staticticsLabel)
        staticticsLabel.snp.makeConstraints { make in
            make.left.equalTo(ageLabel.snp.right).offset(3)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(substrateView).offset(Self.labelsCenterYOffset)
            make.height.equalTo(20)
        }
    }
    
}
