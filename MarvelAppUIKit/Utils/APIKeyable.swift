//
//  APIKeyable.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

class BaseENV {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist") else {
            fatalError("Couldn't find file '\(resourceName).plist'.")
        }
        
        guard let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Plist corrupted")
        }
        self.dict = plist
    }
}

protocol APIKeyable {
    var SERVICE_API_KEY: String { get }
    var TIME_STAMP: String { get }
    var SERVICE_HASH: String { get }
}

final class ProdENV: BaseENV, APIKeyable {
    init() {
        super.init(resourceName: "Keys")
    }
    
    var SERVICE_API_KEY: String {
        return dict.object(forKey: "SERVICE_API_KEY") as? String ?? ""
    }
    
    var TIME_STAMP: String {
        return dict.object(forKey: "TIME_STAMP") as? String ?? ""
    }
    
    var SERVICE_HASH: String {
        return dict.object(forKey: "SERVICE_HASH") as? String ?? ""
    }
}

