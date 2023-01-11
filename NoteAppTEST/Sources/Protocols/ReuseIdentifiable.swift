//
//  ReuseIdentifiable.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
