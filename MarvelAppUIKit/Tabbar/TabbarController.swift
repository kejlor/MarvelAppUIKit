//
//  TabbarController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class TabbarController: UITabBarController {
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addViewControllers(_ vcs: [UIViewController]) {
        let items = [UITabBarItem(tabBarSystemItem: .favorites, tag: 0),
                     UITabBarItem(tabBarSystemItem: .search, tag: 1)]
                //tu tworzysz itemy dolnego paska
            setViewControllers(vcs, animated: true)
            
            for (index, vc) in vcs.enumerated() {
                vc.tabBarItem = items[index]
            }
        }
}

