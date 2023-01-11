//
//  CoreDataServiceError.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 25.12.2022.
//

import Foundation

private extension Constants {
    static let titleFailedToFetchData = "Не удалось получить данные из CoreData"
    static let titleFailedToSaveContext = "Не удалось сохранить изменения в CoreData"
}

enum CoreDataServiceError: Error {
    case failedToFetchData
    case failedToSaveContext
    
    var errorDescription: String {
      switch self {
      case .failedToFetchData:
          return Constants.titleFailedToFetchData
      case .failedToSaveContext:
          return Constants.titleFailedToSaveContext
      }
    }
}
