//
//  SearchTextField.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import UIKit
import Core

protocol SearchTextFieldDelegate: AnyObject {
    func editingDidEnd(_ sender: SearchTextField)
}

class SearchTextField: UIView {
    private lazy var magnifyingglassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
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
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
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
        return CGSize(width: UIView.noIntrinsicMetric, height: SearchTextFieldParameters.intrinsicHeightSize)
    }
}

extension SearchTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubviews(magnifyingglassImageView, searchTextField)

        magnifyingglassImageView.anchor(left: leftAnchor, paddingLeft: SearchTextFieldParameters.magnifyingglassImageViewPadding)
        searchTextField.anchor(top: topAnchor, left: magnifyingglassImageView.rightAnchor, right: rightAnchor, paddingLeft: SearchTextFieldParameters.searchTextFieldPadding)
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

enum SearchTextFieldParameters {
    static let intrinsicHeightSize: CGFloat = 60
    static let magnifyingglassImageViewPadding: CGFloat = 20
    static let searchTextFieldPadding: CGFloat = 5
}
