//
//  RestaurantDetailView.swift
//  Foursquare-Map-Project
//
//  Created by Lilia Yudina on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class RestaurantDetailView: UIView {
    
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
       
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                return label
    } ()
    
    public lazy var restuarantImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    public lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    } ()
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Description1"
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.isEditable = false
        return textView
    } ()
    
    public lazy var description2TextView: UITextView = {
        let textView = UITextView()
        textView.text = "Description2"
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.isEditable = false
        return textView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
    setupDescription2TextView()
    setupDescription1TextView()
    setupLocationLabel()
    setupRestaurantImage()
    setupTitleLabel()
    setupFavoriteButton()
    backgroundColor = .systemPink
    }
    
    private func setupFavoriteButton() {
        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupRestaurantImage() {
        addSubview(restuarantImage)
        restuarantImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restuarantImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            restuarantImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            restuarantImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            restuarantImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: 0.40)
        ])
    }
    
    private func setupLocationLabel() {
        addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: restuarantImage.bottomAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupDescription1TextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupDescription2TextView() {
        addSubview(description2TextView)
        description2TextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        description2TextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
        description2TextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        description2TextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
    }
}
