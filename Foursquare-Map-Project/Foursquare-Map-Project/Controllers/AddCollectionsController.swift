//
//  AddCollectionsController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class AddCollectionsController: UIViewController {
    
    var addCollections = AddCollectionsView()
    var savedVenue:SavedVenue
    
    var dataPersistence: DataPersistence<[Category]>
    
    init(_ savedVenue: SavedVenue, _ dataPersistence: DataPersistence<[Category]>) {
        self.savedVenue = savedVenue
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = addCollections
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
    }

}
