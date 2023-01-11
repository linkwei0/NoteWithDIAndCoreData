//
//  AlertShowing.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 25.12.2022.
//

import UIKit

protocol AlertShowing {
    func showInfoAlert(title: String?, description: String?, cancelButtonTitle: String?)
}

extension AlertShowing where Self: UIViewController {
    func showInfoAlert(title: String?, description: String?, cancelButtonTitle: String?) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel))
        present(alert, animated: true)
    }
}
