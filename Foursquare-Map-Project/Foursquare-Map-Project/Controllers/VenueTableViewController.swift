//
//  VenueTableViewController.swift
//  Foursquare-Map-Project
//
//  Created by Bienbenido Angeles on 2/28/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class VenueTableViewController: UIViewController {

    let venueTableView = TableView()
    var venue = [Venue]()

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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Couldn't dequeue a TableViewCell")
        }
//        let venue = venue[indexPath.row]
        return cell
    }

}

extension VenueTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
