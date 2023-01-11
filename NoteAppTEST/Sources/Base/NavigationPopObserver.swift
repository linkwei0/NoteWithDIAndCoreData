//
//  NavigationPopObserver.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

class NavigationPopObserver {
    let observedViewController: UIViewController
    
    private let coordinator: Coordinator
    
    init(observedViewController: UIViewController, coordinator: Coordinator) {
        self.observedViewController = observedViewController
        self.coordinator = coordinator
    }
    
    func didObservePop() {
        coordinator.onDidFinish?()
    }
}
