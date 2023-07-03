//
//  SearchListView.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 03/07/2023.
//

import UIKit

class SearchListView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(ComicsCell.self, forCellReuseIdentifier: ComicsCell.reuseID)
        tableView.rowHeight = ComicsCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField(placeHolderText: "SearchListViewControllerSearchTextFieldPlaceholder".localized)
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.delegate = self
        textField.backgroundColor = .magenta
        return textField
    }()
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .green
        stack.distribution = .equalCentering
        stack.alignment = .top
        verticalStackView.addArrangedSubview(tableView)
        verticalStackView.addArrangedSubview(emptySearchView)
        return stack
    }()
    private lazy var emptySearchView = {
        let empty = EmptySearchListView(listStatus: .emptyList)
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.backgroundColor = .yellow
                empty.isHidden = false
        return empty
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension SearchListView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
    }
}
