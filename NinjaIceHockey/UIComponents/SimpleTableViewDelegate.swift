//
//  TableViewDelegate.swift
//  NinjaIceHockey
//
//  Created by Александр on 23.11.2022.
//

import UIKit

class SimpleTableViewDelegate: NSObject, UITableViewDelegate {
    
    let height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height        
    }
    
    
}
