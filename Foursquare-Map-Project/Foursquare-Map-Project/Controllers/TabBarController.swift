//
//  TabBarController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var searchNavController: UINavigationController = {
        let navC = UINavigationController(rootViewController: ViewController())
        navC.navigationBar.prefersLargeTitles = true
        return navC
    }()
    
    private lazy var collectionsNavController: UINavigationController = {
        let navC = UINavigationController(rootViewController: CollectionsViewController())
        navC.navigationBar.prefersLargeTitles = true
        navC.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "folder"), tag: 1)
        return navC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchNavController, collectionsNavController]
       
    }
    

 

}
