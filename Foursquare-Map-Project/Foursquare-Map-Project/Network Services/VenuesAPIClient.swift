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
    static func getVenues(query: String, latLong: String,  completion: @escaping (Result <[Venue],AppError>)-> ()) {
        
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "food"
        
        let endpointURLString =
        "https://api.foursquare.com/v2/venues/search?ll=\(latLong)&client_id=\(Chain.id)&client_secret=\(Chain.secret)&v=20200221&query=\(searchQuery)&limit=2"
        
        print(endpointURLString)
        
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
    
    static func getPhoto(venuesID: String ,completion: @escaping (Result <Items, AppError>)-> ()) {
        let endpointURLString = "https://api.foursquare.com/v2/venues/\(venuesID)/photos?client_id=\(Chain.id)&client_secret=\(Chain.secret)&v=20200221"
        
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
                    let picture = photos.response.photos.items.first
                    completion(.success(picture!))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
