//
//  Creator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

struct CreatorResponse: Codable {
    let items: [Creator]
}

struct Creator: Codable {
    let name: String
}
