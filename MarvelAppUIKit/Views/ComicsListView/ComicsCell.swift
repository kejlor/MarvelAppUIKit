//
//  ComicsCell.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 28/06/2023.
//

import UIKit
import Kingfisher

class ComicsCell: UITableViewCell {
    let comicViewModel: ComicViewModel? = nil
    let comicTitle = UILabel()
    let comicWritters = UILabel()
    let comicDescription = UILabel()
    let comicImage = UIImageView()
    let horizontalStackView = UIStackView()
    let stackView = UIStackView()
    let chevronImageView = UIImageView()
    static let reuseID = "ComicsCell"
    static let rowHeight: CGFloat = 200
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ComicsCell {
    private func setup() {
        comicTitle.translatesAutoresizingMaskIntoConstraints = false
        comicTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        comicTitle.font = UIFont.boldSystemFont(ofSize: comicTitle.font.pointSize)
        comicTitle.lineBreakMode = .byWordWrapping
        comicTitle.numberOfLines = 0

//        comicTitle.adjustsFontSizeToFitWidth = true
        comicTitle.text = "Comics title"
        
        comicWritters.translatesAutoresizingMaskIntoConstraints = false
        comicWritters.font = UIFont.preferredFont(forTextStyle: .caption1)
//        comicWritters.adjustsFontSizeToFitWidth = true
        comicWritters.text = "Comics writters"
        comicWritters.lineBreakMode = .byWordWrapping
        comicWritters.numberOfLines = 3
        
        comicDescription.translatesAutoresizingMaskIntoConstraints = false
        comicDescription.font = UIFont.preferredFont(forTextStyle: .caption1)
        comicDescription.text = "Comics description"
        comicDescription.numberOfLines = 3
        comicDescription.lineBreakMode = .byTruncatingTail
        
        
        comicImage.translatesAutoresizingMaskIntoConstraints = false
        comicImage.contentMode = .scaleToFill
//        comicImage.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        comicImage.clipsToBounds = true
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")
        chevronImageView.image = chevronImage
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
    }
    
    private func layout() {
        horizontalStackView.addArrangedSubview(comicImage)
        stackView.addArrangedSubview(comicTitle)
        stackView.addArrangedSubview(comicWritters)
        stackView.addArrangedSubview(comicDescription)
        horizontalStackView.addArrangedSubview(stackView)
        
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(chevronImageView)
        
        // priorities
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            horizontalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: horizontalStackView.bottomAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: horizontalStackView.trailingAnchor, multiplier: 2),
//            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
//            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: comicImage.trailingAnchor, multiplier: 2),
//            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3),
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 2)
        ])
    }
}

extension ComicsCell {
    func configure(with comicVM: ComicViewModel) {
        comicTitle.text = comicVM.title
        comicWritters.text = comicVM.creators
        comicDescription.text = comicVM.description
        comicImage.kf.setImage(with: URL(string: "\(comicVM.thumbnailPath).jpg"))
    }
}

enum ComicsCellParameters {
    static let rowHeight: CGFloat = 200
    static let comicTitleLines: CGFloat = 0
    static let comicWritersLines: CGFloat = 3
    static let comicDescriptionLines: CGFloat = 3
    static let verticalStackSpacing: CGFloat = 10
    static let horizontalStackSpacing: CGFloat = 10
    static let layoutMultiplier: CGFloat = 2
}
