//
//  ServicesContainer.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 05/07/2023.
//

import Foundation
import Swinject

class ServicesContainer {
    static let sharedContainer = ServicesContainer()
    let container = Container()
    
    private init() {
        setupContainer()
    }
    
    private func setupContainer() {
        container.register(NetworkServiceProtocol.self) { _ in
            return NetworkService()
        }
    }
}
