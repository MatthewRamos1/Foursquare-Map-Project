//
//  AddCollectionsController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class AddCollectionsController: UIViewController {
    
    var addCollections = AddCollectionsView()
    
    override func loadView() {
        view = addCollections
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
    }

}
