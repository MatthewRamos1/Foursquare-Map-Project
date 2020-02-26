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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Results"
        resultsView.tableView.dataSource = self
        
    }
    
    override func loadView() {
        view = resultsView
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        return cell
    }
    
    
}
