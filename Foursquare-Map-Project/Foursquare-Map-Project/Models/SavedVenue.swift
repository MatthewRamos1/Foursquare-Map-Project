//
//  SavedVenue.swift
//  Foursquare-Map-Project
//
//  Created by Matthew Ramos on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import AVFoundation

struct SavedVenue {
    let name: String
    let categoryName: String
    let address: String
    let imageData: Data
}

func createSavedVenue(venue: Venue, image: UIImage) -> SavedVenue? {
    let size = UIScreen.main.bounds.size
    let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
    let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
    guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
        return nil
    }
    let address = venue.location.address ?? ""
    let category = venue.categories.first
    let categoryName = category?.name ?? ""
    
    let savedVenue = SavedVenue(name: venue.name, categoryName: categoryName, address: address, imageData: resizedImageData)
    return savedVenue
    
}


