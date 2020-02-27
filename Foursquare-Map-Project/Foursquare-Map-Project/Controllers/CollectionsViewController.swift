//
//  CollectionsViewController.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

enum CategoryState {
  case newCategory
  case existingCategory
}

class CollectionsViewController: UIViewController {
    
    private let collectionView = CollectionsView()
    public var category: Category?
    public var categories = [Category](){
        didSet{
            self.collectionView.collectionView.reloadData()
        }
    }
    public private(set) var categorytState = CategoryState.newCategory
    
    private var containerViewHeight:CGFloat!
    private var containerViewTopAnchor: NSLayoutConstraint!
     private var newContainerViewTopAnchor: NSLayoutConstraint!
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(doneButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var categoryTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .systemGray
        textField.placeholder = "Enter the category name"
        return textField
    }()
    lazy var instructionLabel: UILabel = {
       let label = UILabel()
        label.text = "Add to or Create Collection"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override func loadView() {
      view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewHeight = view.frame.height - 195
        view.backgroundColor = .systemBackground
        navigationItem.title = "Collections"
        setupInstructionLabel()
        setupCategoryTextFieldConstraints()
        setupContainerViewConstraints()
        setupDoneButtonConsgtraints()
            collectionView.collectionView.dataSource = self
            collectionView.collectionView.delegate = self
        categoryTextField.delegate = self
        collectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionsCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed))
        
    }
    
    private func loadCategories() {
        if let category = category {
            self.category = category
            categoryTextField.text = category.name
            categorytState = .existingCategory
        } else {
            categorytState = .newCategory
        }
    }
    
    @objc func plusButtonPressed(sender:UIBarButtonItem){
        containerViewTopAnchor.isActive = false
        newContainerViewTopAnchor.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    func viewPopsDown() {
        containerViewTopAnchor.isActive = true
        newContainerViewTopAnchor.isActive = false
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func doneButtonPressed(sender:UIButton) {

        let imageData = UIImage(systemName: "photo")?.pngData()
        
        let category = Category(name: categoryTextField.text ?? "Category Name", image: imageData!)
        showAlert(title: nil, message: "Do you want to add a new category?") { (alertaction) in
            if alertaction.style == .default{
                self.viewPopsDown()
                self.categories.append(category)
            } else if alertaction.style == .cancel {
                self.viewPopsDown()
            }
        }
        
        //todo: we have to check to see if the category has been saved
        //categories.append(category)
    }
    private func setupInstructionLabel() {
        containerView.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 100),
            instructionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            instructionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20)
        ])
    }
    private func setupCategoryTextFieldConstraints() {
        containerView.addSubview(categoryTextField)
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTextField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 200),
            categoryTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            categoryTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            categoryTextField.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07)
        ])
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
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionsCell", for: indexPath) as? CollectionViewCell else {
            fatalError("could not downcast to CollectionViewCell")
        }
        cell.backgroundColor = .systemBackground
        
        let category = categories[indexPath.row]
        cell.configureCell(category: category)
       
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

extension CollectionsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
   
    category?.name = textField.text ?? "no event name"
    
    return true
  }
}
