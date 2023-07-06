//
//  SearchCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import UIKit
import Swinject

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parent: Coordinator?
    var viewControllerContainer = ViewControllerContainer.sharedConainer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getSearchListVC() -> SearchListViewController {
        return viewControllerContainer.container.resolve(SearchListViewController.self)!
    }
    
    func start() {
        guard let searchListVC = viewControllerContainer.container.resolve(SearchListViewController.self) else { return }
        searchListVC.coordinator = self
        searchListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        navigationController.pushViewController(searchListVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
}
