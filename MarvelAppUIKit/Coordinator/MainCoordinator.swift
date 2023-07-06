//
//  MainCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit
import Swinject

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parent: Coordinator?
    var container = ViewControllerContainer.sharedContainer.container
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getComicsListVC() -> ComicsListViewController {
        return container.resolve(ComicsListViewController.self)!
    }
    
    func start() {
        guard let comicsListVC = container.resolve(ComicsListViewController.self) else { return }
        comicsListVC.coordinator = self
        comicsListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        navigationController.pushViewController(comicsListVC, animated: false)
        navigationController.pushViewController((container.resolve(ComicsListViewController.self)!), animated: false)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
}
