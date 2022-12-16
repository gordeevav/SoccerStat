//
//  UIColor.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import UIKit

extension UIColor {
    static let appWhite = UIColor.white
    static let appGray = UIColor.gray
    static let appBlack = UIColor.black
    static let appOrange = UIColor(hexRed: 0xF2, hexGreen: 0x97, hexBlue: 0x3D)
    static let appTableSeparatorColor = UIColor(hexRed: 0x26, hexGreen: 0x34, hexBlue: 0x43)
  
    static let appBackground = UIColor(hexRed: 0x24, hexGreen: 0x2A, hexBlue: 0x35)
    
    convenience init(hexRed: UInt, hexGreen: UInt, hexBlue: UInt, hexAlpha: UInt = 255) {
        self.init(
            red: CGFloat(hexRed) / 255.0,
            green: CGFloat(hexGreen) / 255.0,
            blue: CGFloat(hexBlue) / 255.0,
            alpha: CGFloat(hexAlpha) / 255.0
        )
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF),
            alpha: alpha
        )
    }
}
