//
//  ConfigurableCoordinator.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
    associatedtype Configuration
    
    init(navigationController: NavigationController,
         appDependency: AppDependency, configuration: Configuration)
}

extension ConfigurableCoordinator {
    init(navigationController: NavigationController, appDependency: AppDependency) {
        fatalError("Use init with configuration for this coordinator")
    }
}
