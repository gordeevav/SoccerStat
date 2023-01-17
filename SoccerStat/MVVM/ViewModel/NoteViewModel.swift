//
//  NoteViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import RxSwift

final class NoteViewModel {
    
    private let coreDataService = CoreDataService()
    
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
            coreDataService.editNote(note, title: title, content: content)
        } else {
            coreDataService.createNote(title: title, content: content)
        }
    }
    
    public func deleteNote() {
        coreDataService.deleteNote(note)
    }
}
