//
//  UIView.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 17.01.2023.
//

import UIKit

extension UIView {
    func inCircle(diameter: CGFloat, borderColor: UIColor = .appOrange, backgroundColor: UIColor = .appBackground, borderWidth: CGFloat = 1) -> Self {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = diameter / 2
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
        
        return self
    }
}
