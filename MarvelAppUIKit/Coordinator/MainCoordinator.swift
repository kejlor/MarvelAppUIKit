//
//  MainCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoorditors: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var tabBarController: UITabBarController { get set}
}

class MainCoordinator: Coordinator {
    var childCoorditors: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let vc = ComicsListViewController()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushToNavController(_ vc: UIViewController) {
        navigationController.pushViewController(vc, animated: true)
    }
    
    func searchList() {
        let vc = SearchListViewController()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        pushToNavController(vc)
    }
    
    func detailComics() {
        let vc = DetailComicsView()
        vc.coordinator = self
        pushToNavController(vc)
    }
}
