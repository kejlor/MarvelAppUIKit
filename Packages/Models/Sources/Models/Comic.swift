//
//  Comic.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import Foundation

public struct ComicsResponse: Decodable {
    public let data: DataResponse
}

public struct Comic: Codable {
    public let id: Int?
    public let title: String?
    public let description: String?
    public let thumbnail: Thumbnail?
    public let creators: CreatorResponse?
    public  let urls: [UrlResponse]?
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(creators, forKey: .creators)
        try container.encode(urls, forKey: .urls)
    }
    
    public init(id: Int?, title: String?, description: String?, thumbnail: Thumbnail?, creators: CreatorResponse?, urls: [UrlResponse]?) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.creators = creators
        self.urls = urls
    }
}
