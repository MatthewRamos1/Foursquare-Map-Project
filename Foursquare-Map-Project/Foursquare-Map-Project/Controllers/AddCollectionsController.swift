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
        addCollections.saveButton.addTarget(self, action: #selector(createNewCollectionWithVenue), for: .touchUpInside)
        addCollections.cancelButton.addTarget(self, action: #selector(cancelCreation), for: .touchUpInside)
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addCollections.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "addedCollectionCell")
        addCollections.collectionView.delegate = self
        addCollections.collectionView.dataSource = self
        loadCategories()
    }
    
    @objc private func createNewCollectionWithVenue(){
        guard let collectionName = addCollections.textField.text, !addCollections.textField.text!.isEmpty else {
            showAlert(title: "Missing Fields", message: "Be sure to add a collection title!")
            return }
        
        let tipDesc = addCollections.tipTextView.text ?? ""
        let venueImageData = savedVenue.imageData
        
        let collection = Category(name: collectionName, image: venueImageData, tipDescription: tipDesc, savedVenue: [self.savedVenue])
        
        if dataPersistence.hasItemBeenSaved(collection){
            showAlert(title: "Dupicated Categories", message: "You can not add duplicate categories to this collection: \(collection.name)")
        } else {
            do {
                // save to documents directory
                try dataPersistence.createItem(collection)
                showAlert(title: "Item was added", message: "Category: \(collection.name) was added to your collection")
                loadCategories()
                //addCollections.collectionView.reloadData()
            } catch {
                showAlert(title: "Saving error", message: "Error: \(error)")
            }
        }
        
    }
    
    @objc private func cancelCreation(){
        dismiss(animated: true, completion: nil)
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
    func didLongPress(_ cell: CollectionViewCell) {
        
    }
    
    func collectionCellAddedVenue(_ cell: CollectionViewCell, oldCategory: Category, venue: SavedVenue) {
        
        guard let indexPath = addCollections.collectionView.indexPath(for: cell) else { return  }
        
        var selectedCategory = collections[indexPath.row]
        selectedCategory.savedVenue?.append(savedVenue)

        if dataPersistence.hasItemBeenSaved(selectedCategory){
            showAlert(title: "Dupicated Venues", message: "You can not add duplicate venues to this collection: \(selectedCategory.name)")
        } else {
            selectedCategory.image = savedVenue.imageData
            cell.restuarantImage.image = UIImage(data: savedVenue.imageData)
                // save to documents directory
            dataPersistence.update(oldCategory, with: selectedCategory)
            showAlert(title: "Item was added", message: "Collection: \(selectedCategory.name) got updated")
        }
        
    }
    
    
}
