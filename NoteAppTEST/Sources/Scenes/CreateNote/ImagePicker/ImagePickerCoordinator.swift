//
//  ImagePickerCoordinator.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 25.12.2022.
//

import UIKit

class ImagePickerCoordinator: NSObject, Coordinator {
    let navigationController: NavigationController
    let appDependency: AppDependency
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    var onNeedsToUpdateNoteImage: ((UIImage) -> Void)?
    
    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.appDependency = appDependency
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showImagePickerScreen(animated: animated)
    }
    
    private func showImagePickerScreen(animated: Bool) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        navigationController.present(imagePicker, animated: animated)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        onNeedsToUpdateNoteImage?(image)
        navigationController.dismiss(animated: true)
    }
}
