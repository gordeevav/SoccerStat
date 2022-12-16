//
//  NoteViewModel.swift
//  NinjaIceHockey
//
//  Created by Александр on 25.11.2022.
//

import Foundation
import RxSwift

final class NoteViewModel {
    
    public let note: Note?
    public let noteSubject = PublishSubject<Note>()
    
    init(note: Note?) {
        self.note = note
    }
    
    public func fetchData() {
        if let note = note {
            noteSubject.onNext(note)
        }
    }
    
    public func saveNote(title: String, content: String) {
        if let note = note {
            CoreDataService.shared.editNote(note, title: title, content: content)
        } else {
            CoreDataService.shared.createNote(title: title, content: content)
        }
    }
    
    public func deleteNote() {
        CoreDataService.shared.deleteNote(note)
    }
}
