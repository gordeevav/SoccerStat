//
//  NotesViewModel.swift
//  NinjaIceHockey
//
//  Created by Александр on 25.11.2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

final class NotesViewModel {
    
//    public let items = BehaviorRelay<[Note]>(value: [])
    public let items = BehaviorRelay(value: [SectionModel(model: "", items: [Note]())])
    
    public func fetchData() {
        DispatchQueue.global().async { [weak self] in
            let notes = CoreDataService.shared.notes()
//            self?.items.accept(notes)
            self?.items.accept(SectionModel(model: "", items: notes))
        }
    }
    
    public func deleteNote(index: Int) {
        var notes = items.value
        guard notes.indices.contains(index) else { return }
        
        let note = notes[index]
        
        CoreDataService.shared.deleteNote(note)
        notes.remove(at: index)
    }
    
}
