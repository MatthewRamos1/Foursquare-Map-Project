//
//  Category.swift
//  Foursquare-Map-Project
//
//  Created by Bienbenido Angeles on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

import UIKit

struct Category: Codable & Equatable {
    var name: String
    var image: Data
    var tipDescription: String?
    var savedVenue:[SavedVenue]?
    
}
