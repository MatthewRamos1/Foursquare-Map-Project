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
import NetworkHelper
import DataPersistence

class ViewController: UIViewController {
    
    private let locationSession = CoreLocationSession()
    
    var mainView = MainView()
    
    var venues = [Venue]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
                self.loadMapView()

            }
        }
    }
    
    var savedVenues = [SavedVenue]()
    
    var latLong = "" {
        didSet {
            
        }
        
    }
    
    
    
    var annotations = [MKPointAnnotation]()
//    var oldAnnotations = [MKPointAnnotation]()
    
    
    var dataPersistence: DataPersistence<Category>
    
    var status:CLAuthorizationStatus?
    
    private var isShowingNewAnnotations = false
    
    init(_ dataPersistence: DataPersistence<Category>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        configureMapView()
        configureCollectionView()
        configureSearchBar()
        loadMapView()
        mainView.cancelButton.addTarget(self, action: #selector(detailButtonWasPressed(_:)), for: .touchUpInside)
        locationSession.delegate = self
    }
    
    func configureCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(LocationsCell.self, forCellWithReuseIdentifier: "venueCell")
    }
    
    func getLocation(query: String, location: String) {
        locationSession.convertPlacemarksToCordinate(adressString: location) { (result) in
            switch result {
            case .failure(let appError):
                print("app Error \(appError)")
            case .success(let latLong):
                //let userLocation = self.locationSession.locationManager.location?.coordinate
//                let region  = MKCoordinateRegion(center: userLocation!, latitudinalMeters: 1600, longitudinalMeters: 1600)
//                self.mainView.mapView.setRegion(region, animated: true)
                
//                if let status = self.status{
//                    if status == .authorizedAlways || status == .authorizedWhenInUse || status == .notDetermined {
//                        let userLocation = self.locationSession.locationManager.location?.coordinate
//
//                        self.latLong = "\(userLocation!.latitude),\(userLocation!.longitude)"
//                    } else {
//                        self.latLong = "\(latLong.lat),\(latLong.long)"
//                    }
//                }
                
//                self.latLong = "\(latLong.lat),\(latLong.long)"

                self.fetchVenues(query: query, location: "\(latLong.lat),\(latLong.long)")

            }
        }
    }
    
    private func configureSearchBar() {
        mainView.searchBar.delegate = self
        mainView.locationSearchBar.delegate = self
    }
    
    private func configureMapView() {
        mainView.mapView.showsUserLocation = true
        mainView.mapView.delegate = self
    }
    
    private func fetchVenues(query: String, location: String) {
        VenuesAPIClient.getVenues(query: query, latLong: location) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let venues):
                self.venues = venues
                print(venues)
            }
        }
        
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        //var oldAnnotations = [MKPointAnnotation]()
        for locations in venues {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locations.location.lat, longitude: locations.location.lng)
            annotation.title = locations.name
            annotations.append(annotation)
        }
         isShowingNewAnnotations = true
        self.annotations = annotations
        
//        if annotations == self.annotations{
//            isShowingNewAnnotations = true
//        } else {
//            annotations = self.oldAnnotations
//            isShowingNewAnnotations = false
//        }
        print(self.annotations)
        return annotations
    }
    
    
    private func loadMapView() {
        let annotations = makeAnnotations()
        DispatchQueue.main.async {
            self.mainView.mapView.removeAnnotations(self.mainView.mapView.annotations)
            self.mainView.mapView.showAnnotations(self.annotations, animated: true)
            self.mainView.mapView.addAnnotations(annotations)
        }
    }
    
    
    @objc
    func detailButtonWasPressed(_ input: UIButton) {
        let resultsVC = ResultsViewController(savedVenues, dataPersistence)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "LocatioAnnotation"
        var annotationView: MKPinAnnotationView
        // try to deque
        if let dequeView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = dequeView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccesoryControllTaped")
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
          if isShowingNewAnnotations {
              DispatchQueue.main.async {
                  mapView.showAnnotations(self.annotations, animated: false)
              }
          }
          isShowingNewAnnotations = false
      }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        
        getLocation(query: mainView.searchBar.text ?? "", location: mainView.locationSearchBar.text ?? "")
        
        resignFirstResponder()
//        if searchBar == mainView.searchBar {
//            getLocation(query: mainView.searchBar.text ?? "", location: mainView.locationSearchBar.text ?? "")
//            searchBar.resignFirstResponder()
//        } else if searchBar == mainView.locationSearchBar {
//            getLocation(query: mainView.searchBar.text ?? "", location: mainView.locationSearchBar.text ?? "")
//            searchBar.resignFirstResponder()
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
   
    
  
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCell", for: indexPath) as? LocationsCell else {
            fatalError("could not get cell")
        }
        let venue = venues[indexPath.row]
        let id = venue.id
        var item: Items!
            VenuesAPIClient.getPhoto(venuesID: id) { (result) in
            switch result {
            case .failure(let appError):
                print("Error: \(appError)")
            case .success(let image):
                item = image
                let imageURL = "\(item.prefix)400x400\(item.suffix)"
                cell.venueImage.getImage1(with: imageURL) { (result) in
                    switch result {
                    case .failure(let appError):
                        print("Error: \(appError)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.venueImage.image = image
                            guard let savedVenue = createSavedVenue(venue: venue, image: image) else {
                                fatalError("couldnt use saved venue at collection view")
                            }
                            self.savedVenues.append(savedVenue)
                      }
                 }
             }
        }
    }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = venues[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? LocationsCell else {
            fatalError("couldnt access cell at didSelect")
        }
        
        guard let image = cell.venueImage.image else {
            fatalError("couldnt access image at didSelect")
        }
        
        guard let savedVenue = createSavedVenue(venue: venue, image: image) else {
            fatalError("couldn't use savedImage at didSelect")
        }
        let detailVC = RestaurantDetailViewController(savedVenue, dataPersistence)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}

extension ViewController: AuthorizationStatusDelegate{
    func authorizationStatusChanged(status: CLAuthorizationStatus) {
        self.status = status
    }
}
