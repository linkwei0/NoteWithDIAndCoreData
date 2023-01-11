//
//  MainCoordinator.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    let navigationController: NavigationController
    let appDependency: AppDependency
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    required init(navigationController: NavigationController, appDependency: AppDependency = AppDependency()) {
        self.appDependency = appDependency
        self.navigationController = navigationController
    }
    
    
    func start(animated: Bool) {
        showNoteListScreen(animated: animated)
    }
    
    private func showNoteListScreen(animated: Bool) {
        show(NoteListCoordinator.self, animated: animated)
    }
}
