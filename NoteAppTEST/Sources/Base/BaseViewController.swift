//
//  BaseViewController.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 22.12.2022.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
    }
}
