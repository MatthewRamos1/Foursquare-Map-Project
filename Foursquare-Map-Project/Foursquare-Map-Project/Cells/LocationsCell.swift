//
//  LocationsCell.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class LocationsCell: UICollectionViewCell {
    
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
        configureVenueImage()
    }
    
    private func configureVenueImage() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: topAnchor),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureImage() {
        
    }
    
    
    
}



