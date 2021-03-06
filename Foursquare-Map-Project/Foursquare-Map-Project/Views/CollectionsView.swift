//
//  CollectionsView.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class CollectionsView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
        public lazy var plusButton: UIButton = {
          let button = UIButton()
          button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    //      button.addTarget(self, action: #selector(plusButtonPressed(_:)), for: .touchUpInside)
          return button
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
       // setupPlusButtonConstraints()
        setupCollectionViewConstraints()
    }
    
    private func setupPlusButtonConstraints() {
      addSubview(plusButton)
      plusButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        plusButton.topAnchor.constraint(equalTo: topAnchor),
        plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        plusButton.heightAnchor.constraint(equalToConstant: 44),
        plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor)
      ])
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
