//
//  ResultsViewController.swift
//  Foursquare-Map-Project
//
//  Created by Matthew Ramos on 2/24/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    let resultsView = ResultsView()
    var savedVenues: [SavedVenue]
    
    init(_ savedVenues: [SavedVenue]) {
        self.savedVenues = savedVenues
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Results"
        resultsView.tableView.dataSource = self
        resultsView.tableView.delegate = self
        resultsView.tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        
    }
    
    override func loadView() {
        view = resultsView
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(savedVenues.count)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultCell else {
            fatalError("Couldn't load resultCell")
        }
        let venue = savedVenues[indexPath.row]
        cell.configureCell(venue: venue)
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 8
    }
}

