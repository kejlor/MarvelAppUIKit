//
//  SearchListController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class SearchListViewController: UIViewController {
    private var searchListComicsVM: SearchComicsListViewModelProtocol
    private var searchListView = SearchListView()
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView.tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        searchListView.tableView.delegate = self
        searchListView.tableView.dataSource = self
        searchListView.searchTextField.delegate = self
        bind()
        layout()
    }
    
    init(searchListComicsVM: SearchComicsListViewModelProtocol) {
        self.searchListComicsVM = searchListComicsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchListViewController {
    private func layout() {
        view.addSubview(searchListView)
        searchListView.fillSafeAreaSuperView()
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
        return SearchListViewControllerParameters.numberOfSections
    }
}

extension SearchListViewController {
    private func getComicsByTitle(title: String) {
        searchListComicsVM.getComicsByTitle(for: title)
    }
    
    private func displayCorrectView() {
        searchListComicsVM.filteredComics.isEmpty ? self.searchListView.showEmptySarchView() : self.searchListView.showTableView()
    }
}

extension SearchListViewController: SearchTextFieldDelegate {
    func editingDidEnd(_ sender: SearchTextField) {
        getComicsByTitle(title: sender.searchTextField.text ?? "")
    }
}

extension SearchListViewController {
    private func showErrorAlert() {
        let alert = UIAlertController(title: "SearchListViewControllerAlertTitle".localized,
                                      message: "SearchListViewControllerAlertMessage".localized,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "SearchListViewControllerAlertButtonTitle".localized, style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func bind() {
        searchListComicsVM.comicsFetchedByTitle = { hasFetchedComicsByTitle in
            DispatchQueue.main.async {
                hasFetchedComicsByTitle ? self.searchListView.showTableView() : self.searchListView.showEmptySarchView()
            }
        }
        
        searchListComicsVM.willShowAlert = { showAlert in
            if showAlert {
                DispatchQueue.main.async {
                    self.showErrorAlert()
                }
            }
        }
    }
}

enum SearchListViewControllerParameters {
    static let numberOfSections: Int = 1
}
