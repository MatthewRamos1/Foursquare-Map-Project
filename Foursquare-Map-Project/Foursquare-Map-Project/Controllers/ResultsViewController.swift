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
        resultsView.tableView.delegate = self
        resultsView.tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        
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

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 8
    }
}

