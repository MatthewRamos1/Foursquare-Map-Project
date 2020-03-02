//
//  CollectionViewCell.swift
//  Foursquare-Map-Project
//
//  Created by Lilia Yudina on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//
import UIKit

protocol CollectionsViewCellDelegate: AnyObject {
    func collectionCellAddedVenue(_ cell: CollectionViewCell, oldCategory: Category, venue: SavedVenue)
    func didLongPress(_ cell: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    

    
    public lazy var restuarantImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .systemBlue
        imageView.image = UIImage(systemName: "photo.fill")
        return imageView
    }()
    
    public lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        //label.backgroundColor = .red
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: . normal)
        button.tintColor = .systemGreen
        button.isHidden = true
        return button
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        
        return gesture
    }()
    
    public weak var delegate: CollectionsViewCellDelegate?
    public var category: Category?
    public var savedVenue: SavedVenue?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {

  
        setupRestaurantImage()
        setupCategoryLabel()
        setupButton()
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc private func addButtonPressed(){
        guard let validSavedVenue = savedVenue, let validOldCategory = category  else { return }
        delegate?.collectionCellAddedVenue(self, oldCategory: validOldCategory, venue: validSavedVenue)
    }
    
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer){
        
        if gesture.state == .began{
            gesture.state = .cancelled
            return
        }
        
        //
        delegate?.didLongPress(self)
    }
    
    //TODO: configureCell has to be refactore to configure the cell based on whether or not it was loaded from the collectionsViewController or the AddCollectionsController
    public func configureCell(category: Category, viewcontroller: UIViewController.Type, savedVenue: SavedVenue? = nil){
        self.category = category
        categoryNameLabel.text = category.name
        restuarantImage.image = UIImage(data: category.image)
        
        if viewcontroller == AddCollectionsController.self{
            addButton.isHidden = false
            self.savedVenue = savedVenue
        } else {
            addGestureRecognizer(longPressGesture)
            addButton.isHidden = true
        }
    }

    
    private func setupRestaurantImage() {
        addSubview(restuarantImage)
        restuarantImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restuarantImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            restuarantImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            restuarantImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            restuarantImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70)
        ])
    }
    
    private func setupCategoryLabel() {
        addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: restuarantImage.bottomAnchor, constant: 10),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupButton(){
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
