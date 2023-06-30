//
//  SearchComicsListViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import Foundation

protocol SearchComicsListViewModelDelegate: AnyObject {
    func didFetchComics(_ comics: [ComicViewModel])
}

final class SearchComicsListViewModel {
    var filteredComics = [ComicViewModel]()
    weak var delegate: SearchComicsListViewModelDelegate?
    private var comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getComicsByTitle(for title: String) async {
        do {
            try await self.filteredComics = comicsRepository.fetchComicsByTitle(title: title).data.results.compactMap(ComicViewModel.init)
            delegate?.didFetchComics(self.filteredComics)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}
