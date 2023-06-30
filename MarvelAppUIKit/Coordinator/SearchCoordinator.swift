//
//  SearchCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 30/06/2023.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parent: Coordinator?
    private let searchListVC = SearchListViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getSearchListVC() -> SearchListViewController {
        return searchListVC
    }
    
    func start() {
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
