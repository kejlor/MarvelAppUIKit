//
//  SearchTextField.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func editingDidEnd(_ sender: SearchTextField)
}

class SearchTextField: UIView {
    private lazy var magnifyingglassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        return imageView
    }()
    public private (set) lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    let placeHolderText: String
    weak var delegate: SearchTextFieldDelegate?
    
    var text: String? {
        get { return searchTextField.text}
        set { searchTextField.text = newValue}
    }
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
}

extension SearchTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(magnifyingglassImageView)
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            magnifyingglassImageView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            magnifyingglassImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: magnifyingglassImageView.trailingAnchor, multiplier: 1),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        magnifyingglassImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        searchTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
}

extension SearchTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
