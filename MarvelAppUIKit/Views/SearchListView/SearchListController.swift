//
//  SearchListController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class SearchListViewController: UIViewController {
    private var searchListComicsVM: SearchComicsListViewModel = SearchComicsListViewModel()
    private var searchListView = SearchListView()
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView.tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        searchListComicsVM.delegate = self
        searchListView.tableView.delegate = self
        searchListView.tableView.dataSource = self
        searchListView.searchTextField.delegate = self
        
        layout()
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
        return 1
    }
}

extension SearchListViewController {
    private func getComicsByTitle(title: String) {
        Task {
            await searchListComicsVM.getComicsByTitle(for: title)
        }
    }
    
    private func displayCorrectView() {
        if searchListComicsVM.filteredComics.isEmpty {
            self.searchListView.showEmptySarchView()
        } else {
            self.searchListView.showTableView()
        }
    }
}

extension SearchListViewController: SearchComicsListViewModelDelegate {
    func didFetchComics(_ comics: [ComicViewModel]) {
        DispatchQueue.main.async {
            self.displayCorrectView()
        }
    }
}

extension SearchListViewController: SearchTextFieldDelegate {
    func editingDidEnd(_ sender: SearchTextField) {
        getComicsByTitle(title: sender.textField.text ?? "")
    }
}


