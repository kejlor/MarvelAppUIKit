//
//  ComicsRepository.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit
import Combine

public class ComicsRepository {
    private var networkService: NetworkService
    private var baseURL = "https://gateway.marvel.com/v1/public/comics"
    private var offsetLimit = 0
    
    var urlString: String {
        return "\(baseURL)?ts=\(ENV.TIME_STAMP)&apikey=\(ENV.SERVICE_API_KEY)&hash=\(ENV.SERVICE_HASH)&limit=25&offset=\(offsetLimit)&orderBy=-onsaleDate"
    }
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchComics() -> AnyPublisher<ComicsResponse, Error> {
        self.offsetLimit = 0
        return networkService.fetchData(url: urlString)
    }
   
    func fetchMoreComics() -> AnyPublisher<ComicsResponse, Error> {
        self.offsetLimit += 100
        return networkService.fetchData(url: urlString)
    }
    
    func fetchComicsByTitle(title: String) -> AnyPublisher<ComicsResponse, Error> {
        let comicsURL = urlString + "&titleStartsWith=\(title)"
        return networkService.fetchData(url: comicsURL)
    }
}
