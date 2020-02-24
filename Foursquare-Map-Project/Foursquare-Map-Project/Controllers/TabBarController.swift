//
//  TabBarController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    private lazy var viewController: ViewController = {
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var collectionsController: CollectionsViewController = {
        let vc = CollectionsViewController()
        vc.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "folder"), tag: 1)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [viewController, collectionsController]
       
    }
    

 

}
