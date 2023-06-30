//
//  SearchListController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class SearchListViewController: UIViewController {
    private var searchListComicsVM: SearchComicsListViewModel = SearchComicsListViewModel()
    weak var coordinator: Coordinator?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        tableView.rowHeight = ComicsCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField(placeHolderText: "Search comics by title")
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.delegate =
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SearchListViewController {
    func setup() {
    }
    
    func layout() {
        
    }
}

extension SearchListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !searchListComicsVM.filteredComics.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseID, for: indexPath) as! ComicsCell
        let comicVM = searchListComicsVM.filteredComics[indexPath.row]
        cell.configure(with: comicVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListComicsVM.filteredComics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchListViewController {
    private func getComicsByTitle(title: String) {
        Task {
            await searchListComicsVM.getComicsByTitle(for: title)
        }
    }
}

extension SearchListViewController: SearchComicsListViewModelDelegate {
    func didFetchComics(_ comics: [ComicViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchListViewController: SearchTextFieldDelegate {
    func editingDidEnd(_ sender: SearchTextField) {
        getComicsByTitle(title: sender.textField.text ?? "")
    }
}

extension SearchListViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

enum SearchListViewControllerParameters {
    
}
