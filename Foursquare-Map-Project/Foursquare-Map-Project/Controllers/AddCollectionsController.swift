//
//  AddCollectionsController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class AddCollectionsController: UIViewController {
    
    var addCollections = AddCollectionsView()
    var savedVenue:SavedVenue
    
    var dataPersistence: DataPersistence<Category>
    
    var collections = [Category](){
        didSet{
            addCollections.collectionView.reloadData()
        }
    }
    
    init(_ savedVenue: SavedVenue, _ dataPersistence: DataPersistence<Category>) {
        self.savedVenue = savedVenue
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = addCollections
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addCollections.collectionView.delegate = self
        addCollections.collectionView.dataSource = self
        loadCategories()
    }
    
    func loadCategories(){
        do{
            self.collections = try dataPersistence.loadItems()
        } catch {
            showAlert(title: "Loading Error", message: "Error: \(error)")
        }
    }

}

extension AddCollectionsController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemSpace: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = numberOfItems * itemSpace
        let itemWidth: CGFloat = (maxSize.width - 20 - totalSpacing) / numberOfItems
        //      let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension AddCollectionsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = addCollections.collectionView.dequeueReusableCell(withReuseIdentifier: "addedCollectionCell", for: indexPath) as? CollectionViewCell else {
            fatalError("could not downcast to CollectionViewCell")
        }
        let category = collections[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.delegate = self
        
        //TODO: configureCell must get refactored
        cell.configureCell(category: category, viewcontroller: AddCollectionsController.self, savedVenue: savedVenue)
        
        return cell
    }
}

extension AddCollectionsController: CollectionsViewCellDelegate{
    func collectionCellAddedVenue(_ cell: CollectionViewCell, venue: SavedVenue) {
        
    }
    
    
}
