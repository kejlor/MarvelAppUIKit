//
//  AppDelegate.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let navController = UINavigationController()
    let tabBarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let coordinator = TabbarCoordinator(navigationController: navController)
        
        coordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navController
        
        return true
    }
}
