//
//  SearchListView.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 03/07/2023.
//

import UIKit

class SearchListView: UIView {
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = ComicsCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = false
        tableView.backgroundColor = .cyan
        tableView.setHeight(350)
        tableView.rowHeight = 300
        return tableView
    }()
    private(set) lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField(placeHolderText: "SearchListViewControllerSearchTextFieldPlaceholder".localized)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .magenta
        return textField
    }()
    private(set) lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .green
        stack.distribution = .equalCentering
        stack.alignment = .top
        stack.setHeight(500)
        return stack
    }()
    private(set) lazy var emptySearchView = {
        let empty = EmptySearchListView(listStatus: .emptyList)
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.backgroundColor = .yellow
        empty.isHidden = true
        return empty
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func layout() {
        verticalStackView.addArrangedSubview(tableView)
//        verticalStackView.addArrangedSubview(emptySearchView)
        
        addSubviews(searchTextField, verticalStackView)
        
        searchTextField.anchor(top: safeTopAnchor, left: safeLeftAnchor)
        verticalStackView.anchor(top: searchTextField.bottomAnchor, left: safeLeftAnchor, bottom: safeBottomAnchor, right: safeRightAnchor)
    }
    
    func showTableView() {
        tableView.isHidden = false
        let estimatedHeight = 200
        let width = self.frame.size.width
        self.tableView.frame = CGRect(x: .zero, y: .zero, width: Int(width), height: estimatedHeight)
        emptySearchView.isHidden = true
        self.tableView.reloadData()
    }
    
    func showEmptySarchView() {
        emptySearchView.isHidden = false
//        tableView.isHidden = true
    }
}

enum SearchListViewParameters {
    static let tableNumberOfRowsInSection: Int = 0
    static let keyboardYDivider: CGFloat = 2
    static let keyboardYMultiplier: CGFloat = -1
}
