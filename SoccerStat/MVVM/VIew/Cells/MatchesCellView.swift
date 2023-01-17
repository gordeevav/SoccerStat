//
//  MatchesCell.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import UIKit
import RxSwift
import SnapKit

final class MatchesCellView: UITableViewCell {

    private static let substratePadding: CGFloat = 6
    private static let normalBackgroundColor: UIColor = .appBlack
    
    private var match: Match?
    private var matchObservable: PublishSubject<Match>?
    
    private var disposeBag = DisposeBag()
    
    private lazy var substrate = UIView() .. {
        addSubview($0)
        
        $0.backgroundColor = Self.normalBackgroundColor
        
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.orange.cgColor
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-Self.substratePadding)
            make.height.equalTo(120)
        }
    }
    
    private lazy var team1LogoImageView = UIImageView() .. {
        substrate.addSubview($0)
        
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(substrate.snp.centerY)
            make.centerX.equalTo(substrate.snp.centerX).multipliedBy(0.4)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    private lazy var team2LogoImageView = UIImageView() .. {
        substrate.addSubview($0)
                
        $0.snp.makeConstraints { make in
            make.centerY.equalTo(substrate.snp.centerY)
            make.centerX.equalTo(substrate.snp.centerX).multipliedBy(1.6)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    private lazy var team1NameLabel = UILabel() .. {
        substrate.addSubview($0)
        
        $0.textAlignment = .center
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(team1LogoImageView)
            make.top.equalTo(team1LogoImageView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(substrate.snp.width).multipliedBy(0.4)
        }
    }
    
    private lazy var team2NameLabel = UILabel() .. {
        substrate.addSubview($0)
        
        $0.textAlignment = .center
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(team2LogoImageView)
            make.top.equalTo(team2LogoImageView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(substrate.snp.width).multipliedBy(0.4)
        }
    }
    
    private lazy var vsLabel = UILabel() .. {
        substrate.addSubview($0)
        
        $0.text = "VS"
        $0.textAlignment = .center
        $0.font = $0.font.withSize(70)
        $0.textColor = .lightGray
        
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(substrate)
            make.centerY.equalTo(substrate)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    private lazy var dateLabel = UILabel() .. {
        substrate.addSubview($0)
        
        $0.textColor = .appWhite
        $0.textAlignment = .center
        
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(substrate)
            make.bottom.equalTo(vsLabel.snp.top).offset(-4)
            make.height.equalTo(20)
            make.width.equalTo(300)
        }
    }
    
    private lazy var historyButton = UIButton() .. {
        contentView.addSubview($0)
        
        $0.setTitle("History", for: .normal)
        $0.backgroundColor = .appOrange
        $0.tintColor = .appWhite
        $0.layer.cornerRadius = 15
        
        $0.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(substrate.snp.top).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let match = self?.match else { return }
            self?.matchObservable?.onNext(match)
        }).disposed(by: disposeBag)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
    }
    
    public func configure(with match: Match, matchObservable: PublishSubject<Match>) {
        self.match = match
        
        dateLabel.text = match.date
        
        team1LogoImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: match.team1.id).url)
        team1NameLabel.text = match.team1.name
        
        team2LogoImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: match.team2.id).url)
        team2NameLabel.text = match.team2.name
        
        self.matchObservable = matchObservable
    }
}
