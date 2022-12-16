//
//  NotesTableCellView.swift
//  NinjaIceHockey
//
//  Created by Александр on 25.11.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    private static let dateFormatter = DateFormatter()
    private static let substratePadding: CGFloat = 6
    
    private let substrateView = UIView() .. {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.orange.cgColor
    }
    
    private let dateLabel = UILabel() .. {
        $0.textColor = .appWhite
        $0.font = $0.font.withSize(12)
        $0.textAlignment = .right
    }
    
    private let dateLabelBorderView = UIView() .. {
        $0.backgroundColor = .appWhite
    }
    
    private let iconImageView = UIImageView() .. {
        $0.tintColor = .appWhite
        $0.image = UIImage(systemName: "doc.text")
    }
    
    private let iconBorderView = UIView() .. {
        $0.backgroundColor = .appWhite
    }
    
    private let titleLabel = UILabel() .. {
        $0.textColor = .appWhite
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMe()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMe()
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

private extension NotesTableViewCell {
    
    func configureMe() {
        addSubViews()
        makeSubViewConstraints()
    }
    
    func addSubViews() {
        addSubview(substrateView)
        substrateView.addSubview(dateLabel)
        substrateView.addSubview(dateLabelBorderView)
        substrateView.addSubview(iconImageView)
        substrateView.addSubview(iconBorderView)
        substrateView.addSubview(titleLabel)
    }
    
    func makeSubViewConstraints() {
        substrateView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Self.substratePadding)
            make.bottom.equalTo(self).offset(-Self.substratePadding)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(substrateView).offset(-10)
            make.bottom.equalTo(substrateView).offset(-2)
            make.height.equalTo(20)
        }
        
        dateLabelBorderView.snp.makeConstraints { make in
            make.width.equalTo(dateLabel)
            make.height.equalTo(1)
            make.bottom.equalTo(dateLabel.snp.top)
            make.right.equalTo(dateLabel)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(substrateView).offset(10)
            make.top.equalTo(substrateView).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        iconBorderView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.bottom.equalTo(iconImageView)
            make.width.equalTo(1)
            make.left.equalTo(iconImageView.snp.right).offset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconBorderView.snp.right).offset(5)
            make.right.equalTo(substrateView).offset(-10)
            make.centerY.equalTo(iconImageView)
            make.height.equalTo(20)
        }
    }
}
