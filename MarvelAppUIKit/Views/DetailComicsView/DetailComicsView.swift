//
//  DetailComicsView.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class DetailComicsView: UIViewController {
    weak var coordinator: MainCoordinator?
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = DetailComicsViewParameters.stackSpacing
        return stack
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DetailComicsViewTitle".localized
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

extension DetailComicsView {
    func layout() {
        verticalStackView.addArrangedSubview(titleLabel)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.fillSuperView()
    }
}

enum DetailComicsViewParameters {
    static let stackSpacing: CGFloat = 20
}
