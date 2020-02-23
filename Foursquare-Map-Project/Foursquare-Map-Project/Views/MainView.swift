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
    
    public lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemRed
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
        configureMapView()
    }
    
    private func configureMapView() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
//    private func configureCollectionView() {
//        addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
//        ])
//    }
    
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
