//
//  CreateNoteViewController.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 23.12.2022.
//

import UIKit

private extension Constants {
    static let defaultImageName = "note.text"
    static let placeholderTextField = "Новая заметка"
    static let nameSaveButton = "Сохранить"
    
    static let alertTitle = "Внимание"
    static let alertMessage = "Введите название заметки"
    static let alertCancelButton = "Понятно"
}

class CreateNoteViewController: BaseViewController, AlertShowing {
    // MARK: - Properties
    
    private var titleTextField = UITextField()
    private lazy var noteImageView = UIImageView()
    private let contentTextView = UITextView()
    
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
        setupNoteImageView()
        setupTitleTextField()
        setupNoteBodyTextView()
        setupSaveButton()
    }
    
    private func setupNoteImageView() {
        view.addSubview(noteImageView)
        noteImageView.image = UIImage(systemName: Constants.defaultImageName)?.withRenderingMode(.alwaysTemplate)
        noteImageView.tintColor = .systemOrange
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
        noteImageView.addGestureRecognizer(tap)
    
        noteImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    private func setupTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.placeholder = Constants.placeholderTextField
        titleTextField.layer.borderColor = UIColor.accentYellow?.cgColor
        titleTextField.layer.borderWidth = 0.7
        titleTextField.layer.cornerRadius = 12
        titleTextField.font = UIFont.boldSystemFont(ofSize: 18)
        titleTextField.setLeftPaddingPoints(12)
        titleTextField.setRightPaddingPoints(12)
        
        titleTextField.addTarget(self, action: #selector(noteNameDidChange), for: .editingChanged)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(noteImageView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    private func setupNoteBodyTextView() {
        view.addSubview(contentTextView)
        contentTextView.indicatorStyle = .white
        contentTextView.layer.borderColor = UIColor.accentYellow?.cgColor
        contentTextView.layer.borderWidth = 0.6
        contentTextView.layer.cornerRadius = 12
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        contentTextView.textContainer.heightTracksTextView = true
        contentTextView.isScrollEnabled = false
        contentTextView.delegate = self
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(150)
        }
    }
    
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.nameSaveButton, image: nil, target: self, action: #selector(saveNote))
    }
    
    // MARK: - Bind
    
    private func bindToViewModel() {
        viewModel.onDidRequestToUpdateViewStorageData = { [weak self] note, noteImage in
            self?.noteImageView.image = noteImage == nil ? UIImage(systemName: Constants.defaultImageName) : noteImage
            self?.titleTextField.text = note?.name
            self?.contentTextView.text = note?.body
        }
        
        viewModel.onDidRequestToUpdateViewTemporyData = { [weak self] name, body, image in
            self?.noteImageView.image = image == nil ? UIImage(systemName: Constants.defaultImageName) : image
            self?.titleTextField.text = name
            self?.contentTextView.text = body
        }
    }
    
    // MARK: - IBActions
    
    @objc private func saveNote() {
        if titleTextField.text != "" {
            viewModel.saveNote(name: titleTextField.text!, body: contentTextView.text)
        } else {
            showInfoAlert(title: Constants.alertTitle, description: Constants.alertMessage,
                          cancelButtonTitle: Constants.alertCancelButton)
        }
    }
    
    @objc private func didTapOnImage() {
        viewModel.openImageController()
    }
    
    @objc private func noteNameDidChange() {
        viewModel.noteDidChange(noteNameText: titleTextField.text, noteBodyText: contentTextView.text)
    }
}

extension CreateNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.noteDidChange(noteNameText: titleTextField.text, noteBodyText: contentTextView.text)
    }
}
