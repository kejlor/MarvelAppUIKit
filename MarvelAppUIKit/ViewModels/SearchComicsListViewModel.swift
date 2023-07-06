//
//  SearchComicsListViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import Foundation
import Combine

protocol SearchComicsListViewModelProtocol {
    func getComicsByTitle(for title: String)
    var filteredComics: [ComicViewModel] { get }
    var comicsFetchedByTitle: (Bool) -> Void { get set }
    var willShowAlert: (Bool) -> Void { get set }
}

final class SearchComicsListViewModel: SearchComicsListViewModelProtocol {
    private(set) var filteredComics = [ComicViewModel]()
    private var comicsRepository: ComicsRepository
    private var bag = Set<AnyCancellable>()
    var comicsFetchedByTitle: (Bool) -> Void = {_ in}
    var willShowAlert: (Bool) -> Void = {_ in}
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }
    
    func getComicsByTitle(for title: String) {
        self.comicsRepository.fetchComicsByTitle(title: title)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.willShowAlert(true)
                    self.comicsFetchedByTitle(false)
                }
            } receiveValue: { [weak self] (comics) in
                self?.filteredComics = []
                self?.filteredComics = comics.data.results.compactMap(ComicViewModel.init)
                self?.checkComicsCount()
            }
            .store(in: &bag)
    }
    
    private func checkComicsCount() {
        if self.filteredComics.count == 0 {
            self.willShowAlert(true)
            self.comicsFetchedByTitle(false)
        } else {
            self.comicsFetchedByTitle(true)
        }
    }
}
