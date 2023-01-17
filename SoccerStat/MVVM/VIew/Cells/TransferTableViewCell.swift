//
//  TransferTableViewCell.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 24.11.2022.
//

import UIKit
import Kingfisher
import SnapKit

final class TransferTableViewCell: UITableViewCell {

    private static let imageSize: CGFloat = 70
    
    private lazy var playerPhotoImageView = UIImageView().inCircle(diameter: Self.imageSize) .. {
        addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-25)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
    }
    
    private lazy var dateLabel = UILabel() .. {
        addSubview($0)
        
        $0.textColor = .appWhite
        $0.backgroundColor = .appOrange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 15
        $0.font = $0.font.withSize(14)
        $0.textAlignment = .center
        
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.height.equalTo(25)
            make.bottom.equalTo(playerPhotoImageView.snp.top).offset(-15)
            make.width.equalTo(self).multipliedBy(0.5)
        }
    }
    
    private lazy var feeAmountLabel = UILabel() .. {
        addSubview($0)
        
        $0.textAlignment = .center
        $0.backgroundColor = .appOrange
        $0.font = $0.font.withSize(12)
        $0.textColor = .appWhite
        
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(playerPhotoImageView).offset(-15)
            make.height.equalTo(20)
            make.left.equalTo(teamFromLogoSubstrateView.snp.centerX)
            make.right.equalTo(teamToLogoSubstrateView.snp.centerX)
        }
    }

    private lazy var playerNameLabel = UILabel() .. {
        addSubview($0)
        
        $0.textAlignment = .center
        $0.backgroundColor = .appOrange
        $0.font = $0.font.withSize(12)
        $0.textColor = .appWhite
        
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(playerPhotoImageView).offset(15)
            make.height.equalTo(20)
            make.left.equalTo(teamFromLogoSubstrateView.snp.centerX)
            make.right.equalTo(teamToLogoSubstrateView.snp.centerX)
        }
    }
    
    private lazy var teamFromLogoImageView = UIImageView() .. {
        teamFromLogoSubstrateView.addSubview($0)
        $0.contentMode = .scaleToFill
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(teamFromLogoSubstrateView)
            make.centerX.equalTo(teamFromLogoSubstrateView)
            make.height.equalTo(teamFromLogoSubstrateView).multipliedBy(0.7)
            make.width.equalTo(teamFromLogoSubstrateView).multipliedBy(0.7)
        }
    }
    
    private lazy var teamFromLogoSubstrateView = UIView().inCircle(diameter: Self.imageSize) .. {
        addSubview($0)
                
        $0.layer.zPosition = 1
        $0.snp.makeConstraints { make in
            make.left.equalTo(playerPhotoImageView.snp.right).offset(10)
            make.centerY.equalTo(playerPhotoImageView)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
    }
    
    private lazy var teamToLogoImageView = UIImageView() .. {
        teamToLogoSubstrateView.addSubview($0)
        $0.contentMode = .scaleToFill
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(teamToLogoSubstrateView)
            make.centerX.equalTo(teamToLogoSubstrateView)
            make.height.equalTo(teamToLogoSubstrateView).multipliedBy(0.7)
            make.width.equalTo(teamToLogoSubstrateView).multipliedBy(0.7)
        }
    }
    
    private lazy var teamToLogoSubstrateView = UIView().inCircle(diameter: Self.imageSize) .. {
        addSubview($0)
                
        $0.layer.zPosition = 1
        $0.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(playerPhotoImageView)
            make.height.equalTo(Self.imageSize)
            make.width.equalTo(Self.imageSize)
        }
    }
    
    public func configure(with transfer: Transfer) {
        playerPhotoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.playerImage(playerId: transfer.playerId).url,
            placeholder: UIImage(named: "playerplaceholder")
        )
        playerNameLabel.text = transfer.playerName
        dateLabel.text = transfer.date
        feeAmountLabel.text = transfer.fee
        teamFromLogoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.teamImage(teamId: transfer.teamFromId).url,
            placeholder: UIImage(named: "teamplaceholder")
        )
        teamToLogoImageView.kf.setImage(
            with: SofaScoreApiEndpoint.teamImage(teamId: transfer.teamToId).url,
            placeholder: UIImage(named: "teamplaceholder")
        )
    }
}
