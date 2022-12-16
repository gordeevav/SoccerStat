//
//  TransferTableViewCell.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import UIKit
import Kingfisher

final class TransferTableViewCell: UITableViewCell {

    private static let imageSize = 70
    
    private var playerPhotoImageView = UIImageView()
    private let dateLabel = UILabel()
    private let feeAmountLabel = UILabel()
    private let playerNameLabel = UILabel()
    
    private let teamFromLogoImageView = UIImageView()
    private var teamFromLogoSubstrateView = UIView()
    
    private let teamToLogoImageView = UIImageView()
    private var teamToLogoSubstrateView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMe()
    }
    
    public func configure(with transfer: Transfer) {
        playerPhotoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.playerImage(playerId: transfer.playerId).url
        )
        playerNameLabel.text = transfer.playerName
        dateLabel.text = transfer.date
        feeAmountLabel.text = transfer.fee
        teamFromLogoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.teamImage(teamId: transfer.teamFromId).url
        )
        teamToLogoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.teamImage(teamId: transfer.teamToId).url
        )
    }
}

private extension TransferTableViewCell {
    
    func configureMe() {
        configurePlayerPhotoImageView()
        configureTeamFromLogoImageView()
        configureTeamToLogoImageView()
        configureDateLabel()
        configureFeeAmountLabel()
        configurePlayerNameLabel()
        
        bringTeamLogosToFront()
    }
    
    func configurePlayerPhotoImageView() {
        addSubview(playerPhotoImageView)
        
        roundView(&playerPhotoImageView)
        
        playerPhotoImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-25)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
    }
    
    func roundView<T: UIView>(_ view: inout T) {
        view.layer.borderColor = UIColor.appOrange.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = CGFloat(Self.imageSize / 2)
        view.clipsToBounds = true
        view.backgroundColor = .appBackground
    }
    
    func configureTeamFromLogoImageView() {
        addSubview(teamFromLogoSubstrateView)
        roundView(&teamFromLogoSubstrateView)
        teamFromLogoSubstrateView.snp.makeConstraints { make in
            make.left.equalTo(playerPhotoImageView.snp.right).offset(10)
            make.centerY.equalTo(playerPhotoImageView)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
        
        teamFromLogoSubstrateView.addSubview(teamFromLogoImageView)
                
        teamFromLogoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(teamFromLogoSubstrateView)
            make.centerX.equalTo(teamFromLogoSubstrateView)
            make.height.equalTo(teamFromLogoSubstrateView).multipliedBy(0.7)
            make.width.equalTo(teamFromLogoSubstrateView).multipliedBy(0.7)
        }
    }
    
    func configureTeamToLogoImageView() {
        addSubview(teamToLogoSubstrateView)
        roundView(&teamToLogoSubstrateView)
        teamToLogoSubstrateView.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(playerPhotoImageView)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
        
        teamToLogoSubstrateView.addSubview(teamToLogoImageView)
                
        teamToLogoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(teamToLogoSubstrateView)
            make.centerX.equalTo(teamToLogoSubstrateView)
            make.height.equalTo(teamToLogoSubstrateView).multipliedBy(0.7)
            make.width.equalTo(teamToLogoSubstrateView).multipliedBy(0.7)
        }
    }
    
    func configureDateLabel() {
        addSubview(dateLabel)
        
        dateLabel.textColor = .appWhite
        dateLabel.backgroundColor = .appOrange
        dateLabel.layer.masksToBounds = true
        dateLabel.layer.cornerRadius = 15
        dateLabel.font = dateLabel.font.withSize(14)
        dateLabel.textAlignment = .center
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.height.equalTo(25)
            make.bottom.equalTo(playerPhotoImageView.snp.top).offset(-15)
            make.width.equalTo(self).multipliedBy(0.5)
        }
    }
    
    func configureFeeAmountLabel() {
        addSubview(feeAmountLabel)
        
        feeAmountLabel.textAlignment = .center
        feeAmountLabel.backgroundColor = .appOrange
        feeAmountLabel.font = dateLabel.font.withSize(12)
        feeAmountLabel.textColor = .appWhite
        
        feeAmountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(playerPhotoImageView).offset(-15)
            make.height.equalTo(20)
            make.left.equalTo(teamFromLogoSubstrateView.snp.centerX)
            make.right.equalTo(teamToLogoSubstrateView.snp.centerX)
        }
    }
    
    func configurePlayerNameLabel() {
        addSubview(playerNameLabel)
        
        playerNameLabel.textAlignment = .center
        playerNameLabel.backgroundColor = .appOrange
        playerNameLabel.font = dateLabel.font.withSize(12)
        playerNameLabel.textColor = .appWhite
        
        playerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(playerPhotoImageView).offset(15)
            make.height.equalTo(20)
            make.left.equalTo(teamFromLogoSubstrateView.snp.centerX)
            make.right.equalTo(teamToLogoSubstrateView.snp.centerX)
        }
    }
    
    func bringTeamLogosToFront() {
        bringSubviewToFront(teamToLogoSubstrateView)
        bringSubviewToFront(teamFromLogoSubstrateView)
    }
    
}
