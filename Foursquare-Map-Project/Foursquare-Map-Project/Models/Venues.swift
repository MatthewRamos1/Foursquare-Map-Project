//
//  Venues.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Response: Codable {
    let response: Venue
}

struct Venue: Codable {
    let venues: [Venues]
}

struct Venues: Codable {
    let id, name: String
    let location: Location
    let categories: [Categories]
}

struct Location: Codable {
    let address: String?
    let lat, lng: Double
    let distance: Int
    let postalCode: String?
    let cc: String
    let neighborhood: String?
    let formattedAddress: [String]
}

struct Categories: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: Icon
}

struct Icon: Codable {
    let prefix: String
    let suffix: String 
}
