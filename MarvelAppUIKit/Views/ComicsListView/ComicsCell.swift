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
    static let rowHeight: CGFloat = ComicsCellParameters.rowHeight
    
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
        comicTitle.numberOfLines = ComicsCellParameters.comicTitleLines
        comicTitle.text = "ComicsCellComicTitle".localized
        
        comicWritters.translatesAutoresizingMaskIntoConstraints = false
        comicWritters.font = UIFont.preferredFont(forTextStyle: .caption1)
        comicWritters.text = "ComicsCellComicWritters".localized
        comicWritters.lineBreakMode = .byWordWrapping
        comicWritters.numberOfLines = ComicsCellParameters.comicWrittersLines
        
        comicDescription.translatesAutoresizingMaskIntoConstraints = false
        comicDescription.font = UIFont.preferredFont(forTextStyle: .caption1)
        comicDescription.text = "ComicsCellComicDescription".localized
        comicDescription.numberOfLines = ComicsCellParameters.comicDescriptionLines
        comicDescription.lineBreakMode = .byTruncatingTail
        
        
        comicImage.translatesAutoresizingMaskIntoConstraints = false
        comicImage.contentMode = .scaleToFill
        comicImage.clipsToBounds = true
        comicImage.widthAnchor.constraint(equalToConstant: ComicsCellParameters.comicImageWidth).isActive = true
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")
        chevronImageView.image = chevronImage
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = ComicsCellParameters.verticalStackSpacing
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = ComicsCellParameters.horizontalStackSpacing
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.alignment = .leading
    }
    
    private func layout() {
        horizontalStackView.addArrangedSubview(comicImage)
        stackView.addArrangedSubview(comicTitle)
        stackView.addArrangedSubview(comicWritters)
        stackView.addArrangedSubview(comicDescription)
        horizontalStackView.addArrangedSubview(stackView)
        
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: ComicsCellParameters.layoutMultiplier),
            horizontalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: ComicsCellParameters.layoutMultiplier),
            bottomAnchor.constraint(equalToSystemSpacingBelow: horizontalStackView.bottomAnchor, multiplier: ComicsCellParameters.layoutMultiplier),
            trailingAnchor.constraint(equalToSystemSpacingAfter: horizontalStackView.trailingAnchor, multiplier: ComicsCellParameters.layoutMultiplier),
            chevronImageView.topAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: ComicsCellParameters.layoutMultiplier)
        ])
    }
}

extension ComicsCell {
    func configure(with comicVM: ComicViewModel) {
        comicTitle.text = comicVM.title
        comicWritters.text = "WrittenByText".localized + comicVM.creators
        comicDescription.text = comicVM.description
        comicImage.kf.setImage(with: URL(string: "\(comicVM.thumbnailPath).jpg"))
    }
}

enum ComicsCellParameters {
    static let rowHeight: CGFloat = 200
    static let comicTitleLines: Int = 0
    static let comicWrittersLines: Int = 3
    static let comicDescriptionLines: Int = 3
    static let verticalStackSpacing: CGFloat = 10
    static let horizontalStackSpacing: CGFloat = 10
    static let layoutMultiplier: CGFloat = 2
    static let comicImageWidth: CGFloat = 140
}
