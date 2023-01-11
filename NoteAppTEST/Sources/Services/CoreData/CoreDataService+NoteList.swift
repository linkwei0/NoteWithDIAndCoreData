//
//  CoreDataService+NoteList.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 25.12.2022.
//

import CoreData

protocol NoteListProtocol {
    func getNotes() -> [Note]
    func removeNote(note: Note)
}

extension CoreDataService: NoteListProtocol {
    func getNotes() -> [Note] {
        do {
            let request = NSFetchRequest<Note>(entityName: "Note")
            let notes = try viewContext.fetch(request)
            return notes
        } catch {
            print(CoreDataServiceError.failedToFetchData.errorDescription)
            return []
        }
    }
    
    func removeNote(note: Note) {
        viewContext.delete(note)
        saveContext()
    }
}
