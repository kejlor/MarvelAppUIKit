//
//  ViewController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    private var comicListVM: ComicListViewModel = ComicListViewModel()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let label = UILabel()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        getComics()
    }
}

extension HomeViewController {
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // ScrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        // StackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

// MARK: - Networking
extension HomeViewController {
    private func getComics() {
        Task {
            try? await comicListVM.getComics()
            label.text = comicListVM.comics[0].title
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    
}
