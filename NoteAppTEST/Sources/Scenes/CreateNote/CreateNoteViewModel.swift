//
//  CreateNoteViewModel.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

protocol CreateNoteViewModelDelegate: AnyObject {
    func viewModelDidRequestToShowNoteList(_ viewModel: CreateNoteViewModel)
    func viewModelDidRequestToOpenImageController(_ viewModel: CreateNoteViewModel)
}

class CreateNoteViewModel {
    typealias Dependencies = HasCreateNoteService
    
    // MARK: - Properties
    
    weak var delegate: CreateNoteViewModelDelegate?
    
    var onDidRequestToUpdateViewStorageData: ((Note?, UIImage?) -> Void)?
    var onDidRequestToUpdateViewTemporyData: ((String?, String?, UIImage?) -> Void)?
    
    private var note: Note?
    private var noteImage: UIImage?
    
    private var noteNameText: String?
    private var noteBodyText: String?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies, note: Note?) {
        self.dependencies = dependencies
        self.note = note
        update(note: note)
    }
    
    // MARK: - Public methods
    
    func viewIsReady() {
        update(note: note)
    }
    
    func saveNote(name: String, body: String) {
        let noteData = NoteData(name: name, body: body, image: noteImage)
        if let note = note {
            dependencies.createNoteService.executeNote(.updateNote(note), data: noteData)
        } else {
            dependencies.createNoteService.executeNote(.saveNote, data: noteData)
        }
        delegate?.viewModelDidRequestToShowNoteList(self)
    }
    
    func updateNoteImage(noteImage: UIImage) {
        self.noteImage = noteImage
        note?.name = noteNameText
        note?.body = noteBodyText
        onDidRequestToUpdateViewTemporyData?(noteNameText, noteBodyText, noteImage)
    }
    
    func openImageController() {
        delegate?.viewModelDidRequestToOpenImageController(self)
    }
    
    func noteDidChange(noteNameText: String?, noteBodyText: String?) {
        self.noteNameText = noteNameText
        self.noteBodyText = noteBodyText
    }
    
    // MARK: - Private methods
    
    private func update(note: Note?) {
        guard let note = note else { return }
        
        noteNameText = note.name
        noteBodyText = note.body
        
        if let imageData = note.image {
            noteImage = UIImage(data: imageData)
        }
        onDidRequestToUpdateViewStorageData?(note, noteImage)
    }
}
