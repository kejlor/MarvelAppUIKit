//
//  PhotosUserDefaults.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 28/06/2023.
//

import UIKit

final class PhotosUserDefaults {
    static let shared = PhotosUserDefaults()
    
    private init() { }
    
    func addToUserDefaults(key: String, value: UIImage) {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(key)
        
        UserDefaults.standard.set(url, forKey: "SavedData")
    }
    
    func getImage(key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    func addComicsToFavourites(value: [ComicViewModel]) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: "Favourites")
        }
    }
    
    func getFavourites() -> [ComicViewModel]? {
        if let data = UserDefaults.standard.object(forKey: "Favourites") as? Data,
           let favourites = try? JSONDecoder().decode([ComicViewModel].self, from: data) {
            return favourites
        }
        
        return nil
    }
}
