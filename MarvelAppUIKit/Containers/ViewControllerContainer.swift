//
//  ViewControllerContainer.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 05/07/2023.
//

import Foundation
import Swinject

class ViewControllerContainer {
    static let sharedContainer = ViewControllerContainer()
    let container = Container()
    let viewModelContainer = ViewModelContainer.sharedContainer
    
    private init() {
        setupContainer()
    }
    
    private func setupContainer() {
        container.register(SearchListViewController.self) { _ in
            return SearchListViewController(searchListComicsVM: self.viewModelContainer.container.resolve(SearchComicsListViewModelProtocol.self)!)
        }
        
        container.register(ComicsListViewController.self) { _ in
            return ComicsListViewController(comicListVM: self.viewModelContainer.container.resolve(ComicListViewModelProtocol.self)!)
        }
    }
}
