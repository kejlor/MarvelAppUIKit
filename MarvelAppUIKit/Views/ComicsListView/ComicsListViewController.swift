//
//  ComicsListViewController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit

class ComicsListViewController: UIViewController {
    private var comicListVM: ComicListViewModel = ComicListViewModel()
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
    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "ComicsListViewController".localized
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        comicListVM.delegate = self
    }
}

extension ComicsListViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        getComics()
    }
    
    private func setupTableView() {        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupTableHeaderView() {
        tableView.tableHeaderView = headerTitle
        headerTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: self.tableView.leadingAnchor, multiplier: ComicsListViewControllerParameters.headerTitleMultiplier).isActive = true
    }
}

extension ComicsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !comicListVM.comics.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseID, for: indexPath) as! ComicsCell
        let comicVM = comicListVM.comics[indexPath.row]
        cell.configure(with: comicVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicListVM.comics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = self.comicListVM.comics.count - ComicsListViewControllerParameters.amountToSubtractFromArray
        if indexPath.row == lastIndex {
            self.getMoreComics()
        }
    }
}

extension ComicsListViewController {
    private func getComics() {
        Task {
            await comicListVM.getComics()
        }
    }
    
    private func getMoreComics() {
        Task {
            await comicListVM.getMoreComics()
        }
    }
}

extension ComicsListViewController: ComicListViewModelDelegate {
    func didFetchMoreComics(_ comics: [ComicViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFetchComics(_ comics: [ComicViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

enum ComicsListViewControllerParameters {
    static let amountToSubtractFromArray: Int = 1
    static let headerTitleMultiplier: CGFloat = 3
}
