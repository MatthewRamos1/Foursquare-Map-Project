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
    
    private var containerViewHeight:CGFloat!
    private var containerViewTopAnchor: NSLayoutConstraint!
     private var newContainerViewTopAnchor: NSLayoutConstraint!
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(doneButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
      view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewHeight = view.frame.height - 200
        view.backgroundColor = .systemBackground
        navigationItem.title = "Collections"
        setupContainerViewConstraints()
        setupDoneButtonConsgtraints()
            collectionView.collectionView.dataSource = self
            collectionView.collectionView.delegate = self
        collectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionsCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed))
        
    }
    
    @objc func plusButtonPressed(sender:UIBarButtonItem){
        containerViewTopAnchor.isActive = false
        newContainerViewTopAnchor.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func doneButtonPressed(sender:UIButton) {
        containerViewTopAnchor.isActive = true
        newContainerViewTopAnchor.isActive = false
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupDoneButtonConsgtraints() {
        containerView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07),
            doneButton.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.15)
        ])

    }
    private func setupContainerViewConstraints() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)
        ])
        containerViewTopAnchor = containerView.topAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewTopAnchor.isActive = true
        
        newContainerViewTopAnchor = containerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -containerViewHeight)
        newContainerViewTopAnchor.isActive = false
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
