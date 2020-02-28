//
//  TableView.swift
//  Foursquare-Map-Project
//
//  Created by Lilia Yudina on 2/28/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TableView: UIView {

    public lazy var venuesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
       setupVenueTableViewConstraints()
    }
    
    private func setupVenueTableViewConstraints() {
        addSubview(venuesTableView)
        venuesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venuesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            venuesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            venuesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            venuesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
