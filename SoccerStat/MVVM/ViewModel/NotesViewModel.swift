//
//  NotesViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

typealias NoteListSectionModel = SectionModel<String, Note>

final class NotesViewModel {
    
    private let coreDataService = CoreDataService()
    public let items = BehaviorRelay(value: [SectionModel(model: "", items: [Note]())])
    
    public func fetchData() {
        DispatchQueue.global().async { [weak self] in
            let notes = self?.coreDataService.notes()
            let section = SectionModel(model: "", items: notes ?? [])
            self?.items.accept([section])
        }
    }
    
    public func deleteNote(index: Int) {
        let notes = items.value.count > 0 ? items.value[0].items : []
        guard notes.indices.contains(index) else { return }
        let note = notes[index]
        
        coreDataService.deleteNote(note)
    }
    
    public let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Note>> (
        configureCell: { _, tableView, indexPath, note in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotesTableViewCell.cellId,
                for: indexPath) as? NotesTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.configure(with: note)
            return cell
        },
        canEditRowAtIndexPath: { _, _ in true }
    )
}
