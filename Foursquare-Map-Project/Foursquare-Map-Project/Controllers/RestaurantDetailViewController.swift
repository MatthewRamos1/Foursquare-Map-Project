//
//  RestaurantDetailViewController.swift
//  Foursquare-Map-Project
//
//  Created by Lilia Yudina on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit
import SafariServices

class RestaurantDetailViewController: UIViewController {

    private var detailView = RestaurantDetailView()
//   private var dataPersistence: DataPersistence<Venues>
    let toolBar = UIToolbar()
    private var savedVenue: SavedVenue
    
    init(_ savedVenue: SavedVenue) {
        self.savedVenue = savedVenue
        super.init(nibName: nil, bundle: nil)
    }
    
//    init(dataPersistence: DataPersistence<Venues>, venue: Venues) {
//        self.dataPersistence = dataPersistence
//        self.venue = venue
//        super.init(nibName: nil, bundle: nil)
//        // self.dataPersistence.delegate = self
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    public func updateUI() {
        detailView.restuarantImage.image = UIImage(data: savedVenue.imageData)
        detailView.titleLabel.text = savedVenue.name
   
    }

}
