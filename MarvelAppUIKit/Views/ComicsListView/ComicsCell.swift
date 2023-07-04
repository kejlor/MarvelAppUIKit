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
    private lazy var comicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = ComicsCellParameters.comicTitleLines
        label.text = "ComicsCellComicTitle".localized
        return label
    }()
    private lazy var comicWritters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "ComicsCellComicWritters".localized
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = ComicsCellParameters.comicWrittersLines
        return label
    }()
    private lazy var comicDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "ComicsCellComicDescription".localized
        label.numberOfLines = ComicsCellParameters.comicDescriptionLines
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    private lazy var comicImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.setWidth(ComicsCellParameters.comicImageWidth)
        return imageView
    }()
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = ComicsCellParameters.horizontalStackSpacing
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = ComicsCellParameters.verticalStackSpacing
        return stackView
    }()
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")
        imageView.image = chevronImage
        return imageView
    }()
    static let reuseID = "ComicsCell"
    static let rowHeight: CGFloat = ComicsCellParameters.rowHeight
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComicsCell {
    private func layout() {
        horizontalStackView.addArrangedSubview(comicImage)
        verticalStackView.addArrangedSubview(comicTitle)
        verticalStackView.addArrangedSubview(comicWritters)
        verticalStackView.addArrangedSubview(comicDescription)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        contentView.addSubviews(horizontalStackView, chevronImageView)
        
        horizontalStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: ComicsCellParameters.horizontalStackPadding, paddingLeft: ComicsCellParameters.horizontalStackPadding)
        chevronImageView.anchor(top: contentView.centerYAnchor, right: contentView.rightAnchor)
    }
}

extension ComicsCell {
    func configure(with comicVM: ComicViewModel) {
        comicTitle.text = comicVM.title
        comicWritters.text = "WrittenByText".localized(comicVM.creators)
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
    static let horizontalStackPadding: CGFloat = 10
}
