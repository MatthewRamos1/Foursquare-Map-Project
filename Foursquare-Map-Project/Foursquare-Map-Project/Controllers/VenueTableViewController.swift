//
//  VenueTableViewController.swift
//  Foursquare-Map-Project
//
//  Created by Bienbenido Angeles on 2/28/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class VenueTableViewController: UIViewController {
    
    var dataPersistence:DataPersistence<Category>

    let venueTableView = TableView()
    var savedVenue = [SavedVenue]()
    
    init(_ savedVenue: [SavedVenue], _ dataPersistence: DataPersistence<Category>) {
        self.savedVenue = savedVenue
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = venueTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationItem.title = "Venues in the Category"
        venueTableView.venuesTableView.dataSource = self
        venueTableView.venuesTableView.delegate = self
        venueTableView.venuesTableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    
}

extension VenueTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedVenue.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Couldn't dequeue a TableViewCell")
        }
        let venue = savedVenue[indexPath.row]
        cell.configureCell(with: venue)
        return cell
    }

}

extension VenueTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venue = savedVenue[indexPath.row]
        let detailVC = RestaurantDetailViewController(venue, dataPersistence)
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
