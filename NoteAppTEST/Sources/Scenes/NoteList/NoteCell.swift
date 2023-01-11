//
//  NoteCell.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    // MARK: - Properties
    
    private let noteNameLabel = UILabel()
    private let noteImage = UIImageView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: NoteCellViewModel) {
        noteNameLabel.text = viewModel.name
        noteImage.image = viewModel.image
        noteImage.isHidden = viewModel.isHiddenImage
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNoteImage()
        setupNoteNameLabel()
    }
    
    private func setupNoteImage() {
        let sizeImage = 40.0
        contentView.addSubview(noteImage)
        noteImage.isHidden = true
        noteImage.clipsToBounds = true
        noteImage.layer.cornerRadius = sizeImage / 2
        noteImage.contentMode = .scaleAspectFill
        noteImage.layer.borderColor = UIColor.accent?.cgColor
        noteImage.layer.borderWidth = 1.0
        noteImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(sizeImage)
        }
    }
    
    private func setupNoteNameLabel() {
        contentView.addSubview(noteNameLabel)
        noteNameLabel.textColor = .black
        noteNameLabel.numberOfLines = 1
        noteNameLabel.textAlignment = .left
        noteNameLabel.snp.makeConstraints { make in
            make.left.equalTo(noteImage.snp.right).offset(7)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
