//
//  SearchComicsListViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import Foundation
import Combine

final class SearchComicsListViewModel {
    @Published private(set) var filteredComics = [ComicViewModel]()
    private var comicsRepository: ComicsRepository
    private var publisher: AnyPublisher<ComicsResponse, Error>?
    private var bag = Set<AnyCancellable>()
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getComicsByTitle(for title: String) async {
        self.comicsRepository.fetchComicsByTitle(title: title)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (comics) in
                self?.filteredComics = []
                self?.filteredComics = comics.data.results.compactMap(ComicViewModel.init)
            }
            .store(in: &bag)
    }
}
