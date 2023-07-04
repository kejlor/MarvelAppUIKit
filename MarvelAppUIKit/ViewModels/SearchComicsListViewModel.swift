//
//  SearchComicsListViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import Foundation
import Combine

protocol SearchComicsListViewModelDelegate: AnyObject {
    func didFetchComics(_ comics: [ComicViewModel])
    func willDisplayAllert()
}

final class SearchComicsListViewModel {
    var filteredComics = [ComicViewModel]()
    weak var delegate: SearchComicsListViewModelDelegate?
    private var comicsRepository: ComicsRepository
    private var publisher: AnyPublisher<ComicsResponse, Error>?
    private var bag = Set<AnyCancellable>()
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getComicsByTitle(for title: String) async {
        try? self.comicsRepository.fetchComicsByTitle(title: title)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { (comics) in
                self.filteredComics = []
                self.filteredComics = comics.data.results.compactMap(ComicViewModel.init)
            }
            .store(in: &bag)
    }
}
