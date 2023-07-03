//
//  TabbarCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class TabbarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabViewController = TabbarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        tabViewController.coordinator = self
        self.setupViewControllers()
        navigationController.pushViewController(tabViewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func setupViewControllers() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.parent = self
        let main = mainCoordinator.getComicsListVC()
        
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator.parent = self
        let search = searchCoordinator.getSearchListVC()
        
        tabViewController.addViewControllers([main, search])
    }
}
