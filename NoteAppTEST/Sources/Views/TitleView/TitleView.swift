//
//  TitleView.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

class TitleView: UIView {
    // MARK: - Properties
    
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
        
    private let titleLabel = UILabel()
    
    // MARK: - Init
    
    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
        
    // MARK: - Setup
    
    private func setup() {
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
