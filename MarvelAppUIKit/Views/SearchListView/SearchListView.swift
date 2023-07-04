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
        return tableView
    }()
    private(set) lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField(placeHolderText: "SearchListViewControllerSearchTextFieldPlaceholder".localized)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setHeight(SearchListViewParameters.searchTextFieldHeight)
        return textField
    }()
    private(set) lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        return stack
    }()
    private(set) lazy var emptySearchView = {
        let empty = EmptySearchListView(listStatus: .emptyList)
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.isHidden = false
        empty.setHeight(SearchListViewParameters.emptySearchView)
        return empty
    }()
    private(set) lazy var tableContainerView: UIView = {
        let tableContainer = UIView()
        tableContainer.translatesAutoresizingMaskIntoConstraints = false
        tableContainer.isHidden = true
        return tableContainer
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
        verticalStackView.addArrangedSubview(tableContainerView)
        verticalStackView.addArrangedSubview(emptySearchView)
        tableContainerView.addSubview(tableView)
        
        addSubviews(searchTextField, verticalStackView)
        
        searchTextField.anchor(top: safeTopAnchor, left: safeLeftAnchor)
        verticalStackView.anchor(top: searchTextField.bottomAnchor, left: safeLeftAnchor, bottom: safeBottomAnchor, right: safeRightAnchor)
        tableContainerView.fillSuperView()
        tableView.fillSuperView()
    }
    
    func showTableView() {
        tableContainerView.isHidden = false
        let width = self.frame.size.width
        self.tableView.frame = CGRect(x: .zero, y: .zero, width: Int(width), height: SearchListViewParameters.tableFrameEstimatedHeight)
        emptySearchView.isHidden = true
        self.tableView.reloadData()
    }
    
    func showEmptySarchView() {
        emptySearchView.checkMessageStatus()
        emptySearchView.isHidden = false
        tableContainerView.isHidden = true
    }
}

enum SearchListViewParameters {
    static let tableNumberOfRowsInSection: Int = 0
    static let keyboardYDivider: CGFloat = 2
    static let keyboardYMultiplier: CGFloat = -1
    static let searchTextFieldHeight: CGFloat = 50
    static let emptySearchView: CGFloat = 150
    static let tableFrameEstimatedHeight: Int = 200
}
