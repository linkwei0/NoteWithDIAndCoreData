//
//  NoteListViewModel.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import Foundation

protocol NoteListViewModelDelegate: AnyObject {
    func viewModelDidRequestToShowCreateNoteScreen(_ viewModel: NoteListViewModel, note: Note?)
}

class NoteListViewModel {
    typealias Dependencies = HasNoteListService & HasCreateNoteService
    
    // MARK: - Properties
    
    weak var delegate: NoteListViewModelDelegate?
    
    var onDidRequestToUpdateView: (() -> Void)?
    
    private(set) var notes: [Note] = []
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public methods
    
    func updateView() {
        loadData()
    }
    
    func showCreateNoteScreen(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            delegate?.viewModelDidRequestToShowCreateNoteScreen(self, note: notes[indexPath.row])
        } else {
            delegate?.viewModelDidRequestToShowCreateNoteScreen(self, note: nil)
        }
    }
    
    func configureCellViewModel(indexPath: IndexPath) -> NoteCellViewModel {
        return NoteCellViewModel(note: notes[indexPath.row])
    }
    
    func removeNote(indexPath: IndexPath) {
        dependencies.noteListService.removeNote(note: notes[indexPath.row])
        notes.remove(at: indexPath.row)
        onDidRequestToUpdateView?()
    }
    
    // MARK: - Private methods
    
    private func loadData() {
        notes = dependencies.noteListService.getNotes()
        onDidRequestToUpdateView?()
    }
}
