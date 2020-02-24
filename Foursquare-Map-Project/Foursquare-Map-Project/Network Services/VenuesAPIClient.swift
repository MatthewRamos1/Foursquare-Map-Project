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
    static func getVenues(query: String, latLong: String,  completion: @escaping (Result <[Venues],AppError>)-> ()) {
        
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "food"
        
        let endpointURLString =
        "https://api.foursquare.com/v2/venues/search?ll=\(latLong)&client_id=5CHW2NMJUZGJIO5UJSSSNCX2XIW4YBPD1Y5W2GCJNGKMILHV&client_secret=0Z4U2L14A5PFIRFQLDTOVUXPH5SKU1NWRWMUPS2MD0PEO0VO&v=20200221&query=\(searchQuery)"
        
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
                    completion(.success(venues.response.venues))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
    
    static func getPhotos(venuesID: String ,completion: @escaping (Result <[Items], AppError>)-> ()) {
        let endpointURLString = "https://api.foursquare.com/v2/venues/\(venuesID)/photos?client_id=5CHW2NMJUZGJIO5UJSSSNCX2XIW4YBPD1Y5W2GCJNGKMILHV&client_secret=0Z4U2L14A5PFIRFQLDTOVUXPH5SKU1NWRWMUPS2MD0PEO0VO&v=20200221"
        
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
                    let photos = try JSONDecoder().decode(Photos.self, from: data)
                    let pictures = photos.response.photos.items
                    completion(.success(pictures))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
}
