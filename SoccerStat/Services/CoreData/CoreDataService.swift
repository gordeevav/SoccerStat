//
//  CoreDataService.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import CoreData

final class CoreDataService {
    
    private lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer = NSPersistentContainer(name: "CoreDataModel") .. {
        $0.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    private func entityDescription(forName entityName: String) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: entityName, in: context)
    }
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Notes CRUD
extension CoreDataService {
    
    public func notes() -> [Note] {
        guard let result = try? context.fetch(Note.fetchRequest()) as NSArray
        else { return [] }

        return result.map { $0 as! Note }
    }
    
    public func createNote(title: String, content: String) {
        guard let entity = entityDescription(forName: Note.entityName())
        else { return }
        
        let note = Note(entity: entity, insertInto: context)
        note.title = title
        note.content = content
        note.createDate = .now
         
        saveContext()
    }
    
    public func editNote(_ note: Note?, title: String, content: String) {
        guard let note = note else { return }
        
        note.title = title
        note.content = content
        
        saveContext()
    }
    
    public func deleteNote(_ note: Note?) {
        guard let note = note else { return }
        
        context.delete(note)        
        saveContext()
    }
    
}
