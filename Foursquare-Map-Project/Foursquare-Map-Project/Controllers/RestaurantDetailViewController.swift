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
    private var dataPersistence: DataPersistence<Category>
    //    let toolBar = UIToolbar()
    private var savedVenue: SavedVenue
    
    var items = [UIBarButtonItem]()
    
    init(_ savedVenue: SavedVenue, _ dataPersistence: DataPersistence<Category>) {
        self.savedVenue = savedVenue
        self.dataPersistence = dataPersistence
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
        view.backgroundColor = .systemBackground
        updateUI()
        configureNavBar()
        
    }
    
    private func configureNavBar() {
//        navigationItem.title = "Programmatic UI"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showCollections))
    }
    
    @objc func showCollections() {
         let collectionsVC = AddCollectionsController(savedVenue, dataPersistence)
        collectionsVC.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(collectionsVC, animated: false, completion: nil)
        
    }
    
    public func updateUI() {
        detailView.restuarantImage.image = UIImage(data: savedVenue.imageData)
        detailView.titleLabel.text = savedVenue.name
        detailView.locationLabel.text = """
        
Address:
\(savedVenue.address)
"""
        detailView.descriptionTextView.text = savedVenue.categoryName


    }
    
}
