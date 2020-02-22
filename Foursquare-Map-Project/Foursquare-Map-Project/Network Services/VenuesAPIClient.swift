//
//  VenuesAPIClient.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import NetworkHelper

struct VenuesAPIClient {
    static func getVenues(completion: @escaping (Result <[Venues],AppError>)-> ()) {
        let endpointURLString = "https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=2WSTB5DPXQTYMXOVPWPS2YLDEKSGMNAOTCCMIGPSVAYERJCJ&client_secret=CU3LAXBBAYNNU1V4FJSFS4JL0V4Z0B3OCBYMBAFAVQT0PNYC&v=20200221&query=tacos"
        
        guard let url = URL(string: endpointURLString) else {
               completion(.failure(.badURL(endpointURLString)))
               return
           }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let venues = try JSONDecoder().decode(Response.self, from: data)
                    let places = venues.response.venues
                    completion(.success(places))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
}
