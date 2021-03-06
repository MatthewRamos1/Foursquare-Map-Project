//
//  TableViewCell.swift
//  Foursquare-Map-Project
//
//  Created by Bienbenido Angeles on 2/28/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  public lazy var venueImage: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(systemName: "photo")
         return imageView
     }()

     public lazy var nameLabel: UILabel = {
         let label = UILabel()
         label.text = "Venue Name"
         label.numberOfLines = 3
         label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
         return label
     }()
    
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Venue Category"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .systemGray2
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         commonInit()
     }

     private func commonInit() {
         setupVenueImage()
         setupNameLabel()
        setupCategoryLabel()
     }

    public func configureCell(with venue: SavedVenue){
        venueImage.image = UIImage(data: venue.imageData)
        nameLabel.text = venue.name
        categoryLabel.text = venue.categoryName
    }

     private func setupVenueImage() {
         addSubview(venueImage)
         venueImage.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             venueImage.topAnchor.constraint(equalTo: topAnchor),
             venueImage.leadingAnchor.constraint(equalTo: leadingAnchor),
             venueImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
             venueImage.widthAnchor.constraint(equalTo: venueImage.heightAnchor)
         ])
     }

     private func setupNameLabel() {
         addSubview(nameLabel)
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             nameLabel.topAnchor.constraint(equalTo: topAnchor),
             nameLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 8),
             nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
         ])
     }
    
    private func setupCategoryLabel(){
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }

}
