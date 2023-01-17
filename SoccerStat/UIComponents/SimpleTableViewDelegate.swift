//
//  TableViewDelegate.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 23.11.2022.
//

import UIKit

final class SimpleTableViewDelegate: NSObject, UITableViewDelegate {
    
    private let height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height        
    }
}
