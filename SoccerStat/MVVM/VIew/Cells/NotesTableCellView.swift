//
//  NotesTableCellView.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import UIKit
import SnapKit

final class NotesTableViewCell: UITableViewCell {

    private static let dateFormatter = DateFormatter()
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
    
    private lazy var dateLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(12)
        $0.textAlignment = .right
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        $0.snp.makeConstraints { make in
            make.right.equalTo(substrateView).offset(-10)
            make.bottom.equalTo(substrateView).offset(-2)
            make.height.equalTo(20)
        }
    }
    
    private lazy var dateLabelBorderView = UIView() .. {
        substrateView.addSubview($0)
        
        $0.backgroundColor = .appWhite
        $0.snp.makeConstraints { make in
            make.width.equalTo(dateLabel)
            make.height.equalTo(1)
            make.bottom.equalTo(dateLabel.snp.top)
            make.right.equalTo(dateLabel)
        }
    }
    
    private lazy var iconImageView = UIImageView() .. {
        substrateView.addSubview($0)
        
        $0.tintColor = .appWhite
        $0.image = UIImage(systemName: "doc.text")
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(substrateView).offset(10)
            make.top.equalTo(substrateView).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    private lazy var iconBorderView = UIView() .. {
        substrateView.addSubview($0)
        
        $0.backgroundColor = .appWhite
        $0.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.bottom.equalTo(iconImageView)
            make.width.equalTo(1)
            make.left.equalTo(iconImageView.snp.right).offset(5)
        }
    }
    
    private lazy var titleLabel = UILabel() .. {
        substrateView.addSubview($0)
        
        $0.textColor = .appWhite
        $0.snp.makeConstraints { make in
            make.left.equalTo(iconBorderView.snp.right).offset(5)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(iconImageView)
            make.height.equalTo(20)
        }
    }
    
    public func configure(with note: Note) {
        titleLabel.text = note.title
        dateLabel.text = Self.dateFormatter.format(from: UInt(note.createDate?.timeIntervalSince1970 ?? 0), dateFormat: "dd.MM.YYYY")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        substrateView.backgroundColor = selected ? .appOrange : .appBackground
    }
}
