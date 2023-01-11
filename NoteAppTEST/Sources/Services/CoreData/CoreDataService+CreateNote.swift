//
//  CoreDataService+CreateNote.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 25.12.2022.
//

import UIKit
import CoreData

enum NoteAction {
    case saveNote
    case updateNote(Note)
}

struct NoteData {
    let name: String
    let body: String?
    let image: UIImage?
}

protocol CreateNoteProtocol {
    func executeNote(_ action: NoteAction, data: NoteData)
}

extension CoreDataService: CreateNoteProtocol {
    func executeNote(_ action: NoteAction, data: NoteData) {
        var note: Note
        
        switch action {
        case .saveNote:
            note = Note(context: viewContext)
        case .updateNote(let updatedNote):
            note = updatedNote
        }
        
        note.name = data.name
        note.body = data.body
        if let image = data.image {
            note.image = image.jpegData(compressionQuality: 1.0)
        }
        
        saveContext()
    }
}
