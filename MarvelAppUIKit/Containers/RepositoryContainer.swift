//
//  RepositoryContainer.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 05/07/2023.
//

import Foundation
import Swinject

class RepositoryContainer {
    static let sharedContainer = RepositoryContainer()
    let container = Container()
    let servicesContainer = ServicesContainer.sharedContainer
    
    private init() {
        setupContainer()
    }
    
    private func setupContainer() {
        container.register(ComicsRepositoryProtocol.self) { _ in
            return ComicsRepository(networkService: self.servicesContainer.container.resolve(NetworkServiceProtocol.self)!)
        }.inObjectScope(.container)
    }
}
