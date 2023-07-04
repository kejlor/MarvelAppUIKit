//
//  ComicListViewModel.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation
import Combine

final class ComicListViewModel {
    @Published private(set) var comics = [ComicViewModel]()
    @Published private(set) var isShowingAlertGetComics = false
    @Published private(set) var isShowingAlertGetMoreComics = false
    private var comicsRepository: ComicsRepository
    private var publisher: AnyPublisher<ComicsResponse, Error>?
    private var bag = Set<AnyCancellable>()
    
    init(comicsRepository: ComicsRepository = ComicsRepository(networkService: NetworkService())) {
        self.comicsRepository = comicsRepository
    }

    func getComics() {
        self.comicsRepository.fetchComics()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (comics) in
                self?.comics = comics.data.results.compactMap(ComicViewModel.init)
                print(comics)
            }
            .store(in: &bag)
    }
    
    func getMoreComics() {
        self.comicsRepository.fetchMoreComics()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (comics) in
                self?.comics.append(contentsOf: comics.data.results.compactMap(ComicViewModel.init))
            }
            .store(in: &bag)
    }
}

class ComicViewModel: Identifiable, Codable {
    private var comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    enum CodingKeys: CodingKey {
        case comic
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.comic = try container.decode(Comic.self, forKey: .comic)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(comic, forKey: .comic)
    }
    
    var id: Int {
        comic.id ?? 0
    }
    
    var title: String {
        comic.title ?? "ComicViewModelTitleNotFound".localized
    }
    
    var description: String {
        comic.description ?? "ComicViewModelEmptyDescription".localized
    }
    
    var thumbnailPath: String {
        comic.thumbnail?.path ?? "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    }
    
    var creators: String {
        var names: [String] = []
        
        for character in comic.creators?.items ?? [] {
            names.append(character.name)
        }
        
        let joinedNames = names.joined(separator: ", ")
        
        if joinedNames == "" {
            return "ComicViewModelCreatorsEmpty".localized
        }
        
        return joinedNames
    }
    
    var moreData: String {
        if comic.urls?[0].type == "ComicViewModelDetail".localized {
            return comic.urls?[0].url ?? ""
        } else {
            return "ComicViewModelMoreData".localized
        }
    }
}

struct CreatorViewModel: Identifiable {
    
    private var creator: Creator
    
    init(creator: Creator) {
        self.creator = creator
    }
    
    var id: String {
        creator.name
    }
    
    var name: String {
        creator.name
    }
}

extension ComicViewModel: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: ComicViewModel, rhs: ComicViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

