//
//  NetworkService.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation
import Combine

class NetworkService {
    var session = URLSession.shared
    private var decoder = JSONDecoder()
    
    enum NetworkServiceError: Error {
        case invalidURL
        case missingData
    }
    
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else { fatalError("Invalid url") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
