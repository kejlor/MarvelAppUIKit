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
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Start typing to find particular comics."
        label.backgroundColor = .blue
        return label
    }()
    private lazy var messageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "book")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    init(listStatus: ListStatus) {
        super.init(frame: CGRect.zero)
        self.listStatus = listStatus
        layout()
//        checkMessageStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptySearchListView {
    func checkMessageStatus() {
        switch listStatus {
        case .emptyList:
            messageLabel.text = "Comics not found. Try providing a correct title."
        case .startTyping:
            messageLabel.text = "Start typing to find particular comics."
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
        
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageIcon.widthAnchor.constraint(equalToConstant: 100),
            messageIcon.heightAnchor.constraint(equalToConstant: 100),
            messageLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
