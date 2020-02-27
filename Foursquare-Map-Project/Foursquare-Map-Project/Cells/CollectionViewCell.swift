//
//  CollectionViewCell.swift
//  Foursquare-Map-Project
//
//  Created by Lilia Yudina on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit



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
    }
    
    public func configureCell(category: Category){
        categoryNameLabel.text = category.name
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
}
