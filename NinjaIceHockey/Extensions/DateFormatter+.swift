//
//  DateFormatter.swift
//  NinjaIceHockey
//
//  Created by Александр on 24.11.2022.
//

import Foundation

extension DateFormatter {
    func format(from timestamp: UInt, dateFormat: String) -> String {
        if timestamp == 0 {
            return "-/-"
        }
        
        self.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        return self.string(from: date)
    }
}
