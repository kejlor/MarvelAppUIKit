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
        window?.rootViewController = container.resolve(ComicsListViewController.self)
        
        return true
    }
}
