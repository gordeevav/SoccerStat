//
//  MatchesCell.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit
import RxSwift

final class MatchesCellView: UITableViewCell {

    private let substrate = UIView()
    
    private let team1LogoImageView = UIImageView()
    private let team2LogoImageView = UIImageView()
    
    private let team1NameLabel = UILabel()
    private let team2NameLabel = UILabel()
    
    private let vsLabel = UILabel()
    private let dateLabel = UILabel()
    private let starButton = UIButton()
    private let historyButton = UIButton()
    
    private let substratePadding: CGFloat = 6
    private var match: Match?
    private var disposeBag = DisposeBag()

    private let normalBackgroundColor: UIColor = .appBlack
    
    private var matchObservable: PublishSubject<Match>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMe()
    }
    
    public func configure(with match: Match, matchObservable: PublishSubject
    <Match>) {
        self.match = match
        
        dateLabel.text = match.date
        
        team1LogoImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: match.team1.id).url)
        team1NameLabel.text = match.team1.name
        
        team2LogoImageView.kf.setImage(with: SofaScoreApiEndpoint.teamImage(teamId: match.team2.id).url)
        team2NameLabel.text = match.team2.name
        
        self.matchObservable = matchObservable
    }
}

private extension MatchesCellView {
    
    func configureMe() {
        configureCell()
        
        configureSubstrate()
        configureHistoryButton()
        
        configureVsLabel()
        configureDateLabel()
        
        configureTeam1LogoImageView()
        configureTeam2LogoImageView()
        
        configureTeam1NameLabel()
        configureTeam2NameLabel()
    }
    
    func configureCell() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
    }
    
    func configureSubstrate() {
        substrate.backgroundColor = normalBackgroundColor
        
        substrate.layer.cornerRadius = 10
        substrate.layer.borderWidth = 1
        substrate.layer.borderColor = UIColor.orange.cgColor
        
        addSubview(substrate)
        substrate.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-substratePadding)
            make.height.equalTo(120)
        }
    }
    
    func configureVsLabel() {
        substrate.addSubview(vsLabel)
        
        vsLabel.text = "VS"
        vsLabel.textAlignment = .center
        vsLabel.font = vsLabel.font.withSize(70)
        vsLabel.textColor = .lightGray
        
        vsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(substrate)
            make.centerY.equalTo(substrate)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func configureDateLabel() {
        substrate.addSubview(dateLabel)
        
        dateLabel.textColor = .appWhite
        dateLabel.textAlignment = .center
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(substrate)
            make.bottom.equalTo(vsLabel.snp.top).offset(-4)
            make.height.equalTo(20)
            make.width.equalTo(300)
        }
    }
    
    func configureTeam1LogoImageView() {
        substrate.addSubview(team1LogoImageView)
        
        team1LogoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(substrate.snp.centerY)
            make.centerX.equalTo(substrate.snp.centerX).multipliedBy(0.4)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func configureTeam1NameLabel() {
        substrate.addSubview(team1NameLabel)
        
        team1NameLabel.textAlignment = .center
        team1NameLabel.textColor = .appWhite
        team1NameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(team1LogoImageView)
            make.top.equalTo(team1LogoImageView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(substrate.snp.width).multipliedBy(0.4)
        }
    }
    
    func configureTeam2LogoImageView() {
        substrate.addSubview(team2LogoImageView)
                
        team2LogoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(substrate.snp.centerY)
            make.centerX.equalTo(substrate.snp.centerX).multipliedBy(1.6)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func configureTeam2NameLabel() {
        substrate.addSubview(team2NameLabel)
        
        team2NameLabel.textAlignment = .center
        team2NameLabel.textColor = .appWhite
        team2NameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(team2LogoImageView)
            make.top.equalTo(team2LogoImageView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(substrate.snp.width).multipliedBy(0.4)
        }
    }
    
    func configureHistoryButton() {
        contentView.addSubview(historyButton)
        
        historyButton.setTitle("History", for: .normal)
        historyButton.backgroundColor = .appOrange
        historyButton.tintColor = .appWhite
        historyButton.layer.cornerRadius = 15
        
        historyButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(substrate.snp.top).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        historyButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let match = self?.match else { return }
            self?.matchObservable?.onNext(match)
        }).disposed(by: disposeBag)
    }
}
