//
//  MainView.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import MapKit

class MainView: UIView {
    
    public lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search for location"
        return searchBar
    }()
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "icons8-menu"), for: .normal)
        return button
    }()
    
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "search for venue"
        return searchBar
    }()
    
    public lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    public lazy var venueImage: UIImageView = {
        let venueImage = UIImageView()
        venueImage.image = UIImage(systemName: "photo")
        venueImage.contentMode = .scaleAspectFit
        return venueImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureButton()
        configureSearchBar()
        configureLocationSearchBar()
        configureMapView()
        configureCollectionView()
    }
    
    private func configureLocationSearchBar() {
        addSubview(locationSearchBar)
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationSearchBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureButton() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    

    
    private func configureSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor)
        ])
    }
    
    private func configureMapView() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        mapView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -100),
            collectionView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            collectionView.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
//    private func configureVenueImage() {
//        addSubview(venueImage)
//        venueImage.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor),
//            venueImage.trailingAnchor.constraint(equalTo: trailingAnchor),
//            venueImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
//        ])
//    }
    
    
    
    
}
