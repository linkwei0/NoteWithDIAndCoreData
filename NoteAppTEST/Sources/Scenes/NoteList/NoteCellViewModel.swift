//
//  NoteCellViewModel.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 24.12.2022.
//

import UIKit
import CoreData

class NoteCellViewModel {
    // MARK: - Properties
    
    var name: String? {
        return note.name
    }
    
    var body: String? {
        return note.body
    }
    
    var image: UIImage? {
        if let image = UIImage(data: note.image ?? Data()) {
            return image
        }
        return nil
    }
    
    var isHiddenImage: Bool {
        note.image == nil ? true : false
    }
    
    private let note: Note
    
    // MARK: - Init
    
    init(note: Note) {
        self.note = note
    }
}
