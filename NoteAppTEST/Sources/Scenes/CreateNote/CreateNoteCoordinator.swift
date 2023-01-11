//
//  CreateNoteCoordinator.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

private extension Constants {
    static let arrowImageName = "arrow.left"
    static let titleViewName = "Новая заметка"
}

struct CreateNoteCoordinatorConfiguration {
    var note: Note?
}

class CreateNoteCoordinator: ConfigurableCoordinator {
    typealias Configuration = CreateNoteCoordinatorConfiguration
    
    let navigationController: NavigationController
    let appDependency: AppDependency
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    var onDidUpdateNoteList: (() -> Void)?
    
    private let configuration: Configuration
    
    required init(navigationController: NavigationController,
                  appDependency: AppDependency, configuration: Configuration) {
        self.appDependency = appDependency
        self.navigationController = navigationController
        self.configuration = configuration
    }
    
    func start(animated: Bool) {
        showCreateNoteScreen(animated: animated)
    }
    
    private func showCreateNoteScreen(animated: Bool) {
        let createNoteViewModel = CreateNoteViewModel(dependencies: appDependency, note: configuration.note)
        createNoteViewModel.delegate = self
        let createNoteVC = CreateNoteViewController(viewModel: createNoteViewModel)
        addPopObserver(for: createNoteVC)
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: Constants.arrowImageName), style: .done, target: self,
                                          action: #selector(closeCreateScreen))
        createNoteVC.navigationItem.leftBarButtonItem = closeButton
        
        let titleView = TitleView(title: Constants.titleViewName)
        createNoteVC.navigationItem.titleView = titleView
        
        navigationController.pushViewController(createNoteVC, animated: animated)
    }
    
    // MARK: - Private methods
    
    @objc private func closeCreateScreen() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - CreateNoteViewModelDelegate

extension CreateNoteCoordinator: CreateNoteViewModelDelegate {
    func viewModelDidRequestToOpenImageController(_ viewModel: CreateNoteViewModel) {
        let coordinator = show(ImagePickerCoordinator.self, animated: true)
        coordinator.onNeedsToUpdateNoteImage = { [weak viewModel] noteImage in
            viewModel?.updateNoteImage(noteImage: noteImage)
        }
    }
    
    func viewModelDidRequestToShowNoteList(_ viewModel: CreateNoteViewModel) {
        navigationController.popViewController(animated: true)
        onDidUpdateNoteList?()
    }
}
