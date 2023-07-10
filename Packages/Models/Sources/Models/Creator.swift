//
//  Creator.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import Foundation

public struct CreatorResponse: Codable {
    public let items: [Creator]
}

public struct Creator: Codable {
    public let name: String
}
