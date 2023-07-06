//
//  ViewModelContainer.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 05/07/2023.
//

import Foundation
import Swinject

class ViewModelContainer {
    static let sharedContainer = ViewModelContainer()
    let container = Container()
    
    private init() {
        self.setupContainers()
    }
    
    private func setupContainers() {
        container.register(ComicListViewModelProtocol.self) { _ in
            return ComicListViewModel()
        }
        
        container.register(SearchComicsListViewModelProtocol.self) { _ in
            return SearchComicsListViewModel()
        }
        
    }
}
