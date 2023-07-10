//
//  APIKeyable.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import Foundation

public class BaseENV {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.module.path(forResource: resourceName, ofType: "plist") else {
            fatalError("Couldn't find file '\(resourceName).plist'.")
        }
        
        guard let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Plist corrupted")
        }
        self.dict = plist
    }
}

public protocol APIKeyable {
    var SERVICE_API_KEY: String { get }
    var TIME_STAMP: String { get }
    var SERVICE_HASH: String { get }
}

public final class ProdENV: BaseENV, APIKeyable {
    init() {
        super.init(resourceName: "Keys")
    }
    
    public var SERVICE_API_KEY: String {
        return dict.object(forKey: "SERVICE_API_KEY") as? String ?? ""
    }
    
    public var TIME_STAMP: String {
        return dict.object(forKey: "TIME_STAMP") as? String ?? ""
    }
    
    public var SERVICE_HASH: String {
        return dict.object(forKey: "SERVICE_HASH") as? String ?? ""
    }
    
    func getAPIKey() -> String? {
        return dict.object(forKey: "SERVICE_API_KEY") as? String ?? ""
    }
}

public var ENV: APIKeyable {
    return ProdENV()
}
