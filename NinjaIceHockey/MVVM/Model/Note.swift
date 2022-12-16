//
//  Note+CoreDataClass.swift
//  
//
//  Created by Александр on 01.12.2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

}

extension Note {

    @nonobjc public static func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: Note.entityName())
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    
    @NSManaged public var createDate: Date?
    @NSManaged public var deleteDate: Date?
}
