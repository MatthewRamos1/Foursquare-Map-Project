//
//  CollectionsViewController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    private let collectionView = CollectionsView()
    
    override func loadView() {
      view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Collections"
            collectionView.collectionView.dataSource = self
            collectionView.collectionView.delegate = self
        collectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionsCell")
    }

}

extension CollectionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionsCell", for: indexPath) as? CollectionViewCell else {
            fatalError("could not downcast to CollectionViewCell")
        }
        cell.backgroundColor = .systemBackground
       
        return cell
    }
}

extension CollectionsViewController: UICollectionViewDelegateFlowLayout {
    
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
