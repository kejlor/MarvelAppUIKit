//
//  ComicsCell.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 28/06/2023.
//

import UIKit

class ComicsCell: UITableViewCell {
    let comicViewModel: ComicViewModel? = nil
    let comicTitle = UILabel()
    let comicWritters = UILabel()
    let comicDescription = UILabel()
    let comicImage = UIImageView()
    let stackView = UIStackView()
    let chevronImageView = UIImageView()
    private var imageLoadVM = ImageLoadViewModel()
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

//        comicTitle.adjustsFontSizeToFitWidth = true
        comicTitle.text = "Comics title"
        
        comicWritters.translatesAutoresizingMaskIntoConstraints = false
        comicWritters.font = UIFont.preferredFont(forTextStyle: .body)
//        comicWritters.adjustsFontSizeToFitWidth = true
        comicWritters.text = "Comics writters"
        
        comicDescription.translatesAutoresizingMaskIntoConstraints = false
        comicDescription.font = UIFont.preferredFont(forTextStyle: .body)
//        comicDescription.adjustsFontSizeToFitWidth = true
        comicDescription.text = "Comics description"
        
        comicImage.translatesAutoresizingMaskIntoConstraints = false
        comicImage.contentMode = .scaleAspectFit
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")
        chevronImageView.image = chevronImage
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
    }
    
    private func layout() {
        stackView.addArrangedSubview(comicTitle)
        stackView.addArrangedSubview(comicWritters)
        stackView.addArrangedSubview(comicDescription)
        
        contentView.addSubview(comicImage)
        contentView.addSubview(stackView)
        contentView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            comicImage.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            comicImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: comicImage.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3),
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
}

extension ComicsCell {
    func configure(with comicVM: ComicViewModel) {
        comicTitle.text = comicVM.title
        comicWritters.text = comicVM.creators
        comicDescription.text = comicVM.description
        Task {
            imageLoadVM.urlString = "\(comicVM.thumbnailPath).jpg"
            imageLoadVM.imageKey = comicVM.title
            await imageLoadVM.downloadCoverImage()
        }
        if let fetchedImage = imageLoadVM.image {
            imageView?.image = fetchedImage
        }
    }
}
