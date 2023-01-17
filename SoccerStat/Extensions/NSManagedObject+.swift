//
//  NSManagedObject.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 01.12.2022.
//

import CoreData

extension NSManagedObject {
    static func entityName() -> String { String(describing: Self.self) }
}
