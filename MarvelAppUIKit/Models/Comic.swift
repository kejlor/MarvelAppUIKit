//
//  Comic.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

struct ComicsResponse: Decodable {
    let data: DataResponse
}

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: Thumbnail?
    let creators: CreatorResponse?
    let urls: [UrlResponse]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(creators, forKey: .creators)
        try container.encode(urls, forKey: .urls)
    }
}
