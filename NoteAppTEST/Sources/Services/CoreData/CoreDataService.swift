//
//  CoreDataService.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit
import CoreData

class CoreDataService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "NoteAppTEST")
        persistentContainer.loadPersistentStores { _, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
        }
        return persistentContainer
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print(CoreDataServiceError.failedToSaveContext.errorDescription)
        }
    }
}
