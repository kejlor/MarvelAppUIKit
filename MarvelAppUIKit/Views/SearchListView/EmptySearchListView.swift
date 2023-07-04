//
//  EmptySearchListView.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class EmptySearchListView: UIView {
    enum ListStatus {
        case emptyList
        case startTyping
    }
    
    private var listStatus = ListStatus.startTyping
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.text = "EmptySearchListViewLabelMessage".localized
        label.setHeight(EmptySearchListViewParameters.iconHeight)
        return label
    }()
    private lazy var messageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "book")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.setWidth(EmptySearchListViewParameters.iconWidth)
        imageView.setHeight(EmptySearchListViewParameters.iconHeight)
        return imageView
    }()
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = EmptySearchListViewParameters.verticalStackSpacing
        stackView.alignment = .center
        return stackView
    }()
    private lazy var spacer: UIView = {
        let customSpacer = UIView()
        customSpacer.translatesAutoresizingMaskIntoConstraints = false
        customSpacer.setHeight(EmptySearchListViewParameters.spacerHeight)
        return customSpacer
    }()
    
    init(listStatus: ListStatus) {
        super.init(frame: CGRect.zero)
        self.listStatus = listStatus
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptySearchListView {
    func checkMessageStatus() {
        switch listStatus {
        case .emptyList:
            messageLabel.text = "EmptySearchListViewComicsNotFound".localized
        case .startTyping:
            messageLabel.text = "EmptySearchListViewLabelMessage".localized
        }
    }
    
    func setListIsEmpty() {
        listStatus = .emptyList
    }
    
    func setStartTyping() {
        listStatus = .startTyping
    }
    
    private func layout() {
        verticalStackView.addArrangedSubview(messageIcon)
        verticalStackView.addArrangedSubview(messageLabel)
        verticalStackView.addArrangedSubview(spacer)
        
        addSubview(verticalStackView)
        verticalStackView.fillSuperView()
    }
}

enum EmptySearchListViewParameters {
    static let verticalStackSpacing: CGFloat = 10
    static let iconWidth: CGFloat = 100
    static let iconHeight: CGFloat = 100
    static let labelHeight: CGFloat = 50
    static let spacerHeight: CGFloat = 500
}
