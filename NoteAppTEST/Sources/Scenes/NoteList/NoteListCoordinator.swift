//
//  NoteListCoordinator.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

private extension Constants {
    static let titleViewMyNotes = "Мои заметки"
}

class NoteListCoordinator: Coordinator {
    let navigationController: NavigationController
    let appDependency: AppDependency
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.appDependency = appDependency
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showNoteListScreen(animated: animated)
    }
    
    private func showNoteListScreen(animated: Bool) {
        let noteListViewModel = NoteListViewModel(dependencies: appDependency)
        noteListViewModel.delegate = self
        let noteListVC = NoteListViewController(viewModel: noteListViewModel)
        addPopObserver(for: noteListVC)

        let titleView = TitleView(title: Constants.titleViewMyNotes)
        noteListVC.navigationItem.titleView = titleView
        
        navigationController.pushViewController(noteListVC, animated: animated)
    }
}

// MARK: - NoteListViewModelDelegate

extension NoteListCoordinator: NoteListViewModelDelegate {
    func viewModelDidRequestToShowCreateNoteScreen(_ viewModel: NoteListViewModel, note: Note?) {
        let coordinator = show(CreateNoteCoordinator.self,
                               configuration: CreateNoteCoordinatorConfiguration(note: note), animated: true)
        coordinator.onDidUpdateNoteList = {
            viewModel.updateView()
        }
    }
}
