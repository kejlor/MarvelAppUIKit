//
//  MainCoordinator.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parent: Coordinator?
    private let comicsListVC = ComicsListViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getComicsListVC() -> ComicsListViewController {
        return comicsListVC
    }
    
    func start() {
        comicsListVC.coordinator = self
        comicsListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        navigationController.pushViewController(comicsListVC, animated: false)
    }
    
    func openDetailComicsView() {
        let vc = DetailComicsView()
        vc.coordinator = self
        //        push(vc)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
}
