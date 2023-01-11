//
//  CreateNoteViewController.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

private extension Constants {
    static let defaultImageName = "plus"
    static let placeholderTextField = "Новая заметка"
    static let nameSaveButton = "Сохранить"
    
    static let alertTitle = "Внимание"
    static let alertMessage = "Введите название заметки"
    static let alertCancelButton = "Понятно"
}

class CreateNoteViewController: BaseViewController, AlertShowing {
    // MARK: - Properties
    
    private var noteNameTextField = UITextField()
    private lazy var noteMainImage = UIImageView()
    private let noteBodyTextView = UITextView()
    
    private let viewModel: CreateNoteViewModel
    
    // MARK: - Init
    
    init(viewModel: CreateNoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        viewModel.viewIsReady()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNoteMainImage()
        setupNoteNameTextField()
        setupNoteBodyTextView()
        setupSaveButton()
    }
    
    private func setupNoteMainImage() {
        let imageSize = 120.0
        view.addSubview(noteMainImage)
        noteMainImage.layer.masksToBounds = false
        noteMainImage.isUserInteractionEnabled = true
        noteMainImage.contentMode = .scaleToFill
        noteMainImage.image = UIImage(systemName: Constants.defaultImageName)
        noteMainImage.layer.borderColor = UIColor.accent?.cgColor
        noteMainImage.layer.borderWidth = 1.0
        noteMainImage.clipsToBounds = true

        noteMainImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnImage)))
        
        noteMainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
            make.size.equalTo(imageSize)
        }
        
        noteMainImage.layer.cornerRadius = imageSize / 2
    }
    
    private func setupNoteNameTextField() {
        view.addSubview(noteNameTextField)
        noteNameTextField.placeholder = Constants.placeholderTextField
        noteNameTextField.layer.borderColor = UIColor.accent?.cgColor
        noteNameTextField.layer.borderWidth = 0.65
        noteNameTextField.layer.cornerRadius = 8
        
        noteNameTextField.addTarget(self, action: #selector(noteNameDidChange), for: .editingChanged)
        
        noteNameTextField.snp.makeConstraints { make in
            make.top.equalTo(noteMainImage.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    private func setupNoteBodyTextView() {
        view.addSubview(noteBodyTextView)
        noteBodyTextView.indicatorStyle = .white
        noteBodyTextView.layer.borderColor = UIColor.accent?.cgColor
        noteBodyTextView.layer.borderWidth = 0.65
        noteBodyTextView.layer.cornerRadius = 8
        noteBodyTextView.font = UIFont.systemFont(ofSize: 16)
        noteBodyTextView.delegate = self
        noteBodyTextView.snp.makeConstraints { make in
            make.top.equalTo(noteNameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.nameSaveButton, image: nil, target: self, action: #selector(saveNote))
    }
    
    // MARK: - Bind
    
    private func bindToViewModel() {
        viewModel.onDidRequestToUpdateViewStorageData = { [weak self] note, noteImage in
            self?.noteMainImage.image = noteImage == nil ? UIImage(systemName: Constants.defaultImageName) : noteImage
            self?.noteNameTextField.text = note?.name
            self?.noteBodyTextView.text = note?.body
        }
        
        viewModel.onDidRequestToUpdateViewTemporyData = { [weak self] name, body, image in
            self?.noteMainImage.image = image == nil ? UIImage(systemName: Constants.defaultImageName) : image
            self?.noteNameTextField.text = name
            self?.noteBodyTextView.text = body
        }
    }
    
    // MARK: - IBActions
    
    @objc private func saveNote() {
        if noteNameTextField.text != "" {
            viewModel.saveNote(name: noteNameTextField.text!, body: noteBodyTextView.text)
        } else {
            showInfoAlert(title: Constants.alertTitle, description: Constants.alertMessage,
                          cancelButtonTitle: Constants.alertCancelButton)
        }
    }
    
    @objc private func didTapOnImage() {
        viewModel.openImageController()
    }
    
    @objc private func noteNameDidChange() {
        viewModel.noteDidChange(noteNameText: noteNameTextField.text, noteBodyText: noteBodyTextView.text)
    }
}

extension CreateNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.noteDidChange(noteNameText: noteNameTextField.text, noteBodyText: noteBodyTextView.text)
    }
}
