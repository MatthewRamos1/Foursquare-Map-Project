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
      label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
      label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
      return label
    } ()
     
    public lazy var descriptionTextView: UILabel = {
      let textView = UILabel()
      textView.text = "Description"
      textView.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
    setupTitleLabel()
    setupRestaurantImage()
    setupLocationLabel()
    setupDescription1TextView()
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
        restuarantImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
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
        descriptionTextView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
        descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
      ])
    }
     
}
