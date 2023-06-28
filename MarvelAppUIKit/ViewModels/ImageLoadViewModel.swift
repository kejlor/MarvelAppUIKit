//
//  ImageLoadViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 28/06/2023.
//

import UIKit

final class ImageLoadViewModel {
    var image: UIImage? = nil
    var isLoading = true
    let photosUserDefaults = PhotosUserDefaults.shared
    private var comicsRepository: ComicsRepository
    var urlString: String = ""
    var imageKey: String = ""
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getImage() async {
        if let storedImage = photosUserDefaults.getImage(key: imageKey) {
            image = storedImage
        } else {
            await downloadCoverImage()
        }
    }
    
    func downloadCoverImage() async {
        do {
            if let image = try await self.comicsRepository.getImage(from: self.urlString) {
                DispatchQueue.main.async {
                    self.image = image
                    self.isLoading = false
                }
            }
        } catch {
            print(error)
        }
    }
}
