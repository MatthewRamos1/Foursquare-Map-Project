//
//  ViewController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/21/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import ImageKit
import MapKit

class ViewController: UIViewController {
    
    var mainView = MainView()
    
//    var venues = [Venues]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.mainView.collectionView.reloadData()
//            }
//        }
//    }
//
//    var item = [Items]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.mainView.collectionView.reloadData()
//            }
//        }
//    }
    
    private let locationSession = CoreLocationSession()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainView.mapView.showsUserLocation = true
        mainView.mapView.delegate = self
        
//        configureCollectionView()
//        loadPhotoData()
    }
    
//    private func configureCollectionView() {
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.delegate = self
//        mainView.collectionView.register(LocationsCell.self, forCellWithReuseIdentifier: "venueCell")
//    }
    
//    func loadPhotoData() {
//        VenuesAPIClient.getVenues(query: "tacos") { (result) in
//            switch result {
//            case .failure(let appError):
//                print("app error \(appError)")
//            case .success(let venues):
//                self.venues = venues
//                var venueIDs = ""
//                for value in venues {
//                    venueIDs = value.id
//                }
//                print(venueIDs.count)
//                VenuesAPIClient.getPhotos(venuesID: venueIDs) { (result) in
//                       switch result {
//                       case .failure(let appError):
//                           print("app error \(appError)")
//                       case .success(let items):
//                           self.item = items
//                       }
//                   }
//            }
//        }
//    }
    
//    func getPhotos() {
//        VenuesAPIClient.getPhotos(venuesID: "" ) { (result) in
//            switch result {
//            case .failure(let appError):
//                print("app error \(appError)")
//            case .success(let items):
//                self.item = items
//            }
//        }
//
//    }
    
}

extension ViewController: MKMapViewDelegate {
    
}



//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return item.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCell", for: indexPath) as? LocationsCell else {
//            fatalError("could not get cell")
//        }
//
//
////        let venue = venues[indexPath.row]
//
//        let photo = item[indexPath.row]
//
//        cell.venueImage.getImage(with: "\(photo.prefix)400x400\(photo.suffix)") { (result) in
//            switch result {
//            case .failure(let appError):
//                print("app error \(appError)")
//            case .success(let image):
//                DispatchQueue.main.async {
//                    cell.venueImage.image = image
//                }
//            }
//        }
//
//        cell.backgroundColor = .gray
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 300, height: 300)
//    }
//}


