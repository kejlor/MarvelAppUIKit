//
//  AppDelegate.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let navController = UINavigationController()
    let tabBarController = UITabBarController()
    let container: Container = {
        let container = Container()
        container.register(NetworkService.self) { _ in
            NetworkService()
        }
        container.register(ComicsRepository.self) { r in
            let controller = ComicsRepository(networkService: r.resolve(NetworkService.self)!)
            return controller
        }
        container.register(ComicListViewModel.self) { r in
            ComicListViewModel(comicsRepository: r.resolve(ComicsRepository.self)!)
        }
        container.register(ComicsListViewController.self) { r in
            let controller = ComicsListViewController(comicListVM: r.resolve(ComicListViewModel.self)!)
            return controller
        }
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let coordinator = TabBarCoordinator(navigationController: navController)
        
        coordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navController
        
        return true
    }
}
