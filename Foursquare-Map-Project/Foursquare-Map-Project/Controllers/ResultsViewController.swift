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
        
    }
    
    override func loadView() {
        view = resultsView
    }
 
}
