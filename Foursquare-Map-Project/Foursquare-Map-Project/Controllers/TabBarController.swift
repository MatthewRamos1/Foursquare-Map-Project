//
//  TabBarController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var searchNavController: ViewController = {
        
        let navC = ViewController()
        navC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return navC
    }()
    
    private lazy var collectionsNavController: CollectionsViewController = {
        let navC = CollectionsViewController()
        navC.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "folder"), tag: 1)
        return navC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vcs = [searchNavController, collectionsNavController].map{UINavigationController(rootViewController: $0)}
        vcs.forEach{$0.navigationController?.navigationBar.prefersLargeTitles = true}
        viewControllers = vcs
    }
    
    
    
    
}
