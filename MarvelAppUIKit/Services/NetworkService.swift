//
//  NetworkService.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

class NetworkService {
    var session = URLSession.shared
    private var decoder = JSONDecoder()
    
    enum NetworkServiceError: Error {
        case invalidURL
        case missingData
    }
    
    func fetchData<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else { throw NetworkServiceError.invalidURL }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(T.self, from: data)
    }
    
    func fetchImage(url: String) async throws -> Data? {
        guard let url = URL(string: url) else { throw NetworkServiceError.invalidURL }
        let (data, _) = try await session.data(from: url)
        return data
    }
}
