//
//  ComicsListViewController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit

class ComicsListViewController: UIViewController {
    private var comicListVM: ComicListViewModel = ComicListViewModel()
    var comics: [ComicViewModel] = []
    var tableView = UITableView()
    let headerTitle = UILabel()

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
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        tableView.rowHeight = ComicsCell.rowHeight
        tableView.tableFooterView = UIView()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        headerTitle.text = "Marvel"
        headerTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        var size = headerTitle.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerTitle.frame.size = size
        
        tableView.tableHeaderView = headerTitle
    }
}

extension ComicsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !comics.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseID, for: indexPath) as! ComicsCell
        let comicVM = comics[indexPath.row]
        cell.configure(with: comicVM)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ComicsListViewController {
    private func getComics() {
        Task {
            await comicListVM.getComics()
        }
    }
}

extension ComicsListViewController: ComicListViewModelDelegate {
    func didFetchComics(_ comics: [ComicViewModel]) {
        self.comics = comics
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
