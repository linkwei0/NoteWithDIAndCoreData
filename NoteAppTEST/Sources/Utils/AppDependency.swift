//
//  AppDependency.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import Foundation

protocol HasNoteListService {
    var noteListService: NoteListProtocol { get }
}

protocol HasCreateNoteService {
    var createNoteService: CreateNoteProtocol { get }
}

class AppDependency {
    private let coreDataService: CoreDataService
    
    init() {
        coreDataService = CoreDataService()
    }
}

// MARK: - HasNoteListService

extension AppDependency: HasNoteListService {
    var noteListService: NoteListProtocol {
        coreDataService
    }
}

// MARK: - HasCreateNoteService

extension AppDependency: HasCreateNoteService {
    var createNoteService: CreateNoteProtocol {
        coreDataService
    }
}
