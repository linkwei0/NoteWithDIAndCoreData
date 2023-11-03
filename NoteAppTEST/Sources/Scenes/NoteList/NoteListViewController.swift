//
//  ViewController.swift
//  NoteAppTEST
//
//  Created by Артём Бацанов on 22.12.2022.
//

import UIKit

private extension Constants {
    static let titleNewNote = "Новая заметка"
    static let heightForFooter = 60.0
}

class NoteListViewController: BaseViewController {
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)
    
    private let viewModel: NoteListViewModel
    
    // MARK: - Init
    
    init(viewModel: NoteListViewModel) {
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
        viewModel.updateView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupTableView()
        setupAppNoteButton()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAppNoteButton() {
        view.addSubview(addButton)
        addButton.setTitle(Constants.titleNewNote, for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 12
        addButton.backgroundColor = .systemOrange
        addButton.addTarget(self, action: #selector(didTapAddNoteButton), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Bind
    
    private func bindToViewModel() {
        viewModel.onDidRequestToUpdateView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - IBActions
    
    @objc private func didTapAddNoteButton() {
        viewModel.showCreateNoteScreen(indexPath: nil)
    }
}

// MARK: - UITableViewDataSource

extension NoteListViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath)
                as? NoteCell else { return UITableViewCell() }
        cell.configure(with: viewModel.configureCellViewModel(indexPath: indexPath))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showCreateNoteScreen(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle
                   , forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeNote(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.heightForFooter
    }
}
