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
    public var createdCategory: Category?
    public var categories = [Category]() {
        didSet{
            self.collectionView.collectionView.reloadData()
        }
    }
    public private(set) var categorytState = CategoryState.newCategory
    
    private var containerViewHeight:CGFloat!
    private var containerViewTopAnchor: NSLayoutConstraint!
    private var newContainerViewTopAnchor: NSLayoutConstraint!
    
    private var dataPersistence: DataPersistence<Category>
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.systemBlue.cgColor
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        //        button.backgroundColor = .systemGray
        button.setTitleColor(.systemBlue, for: .normal)
        //        button.layer.borderWidth = 1.0
        //        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(doneButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        //        textField.backgroundColor = .systemGray
        textField.layer.borderWidth = 3.0
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.placeholder = "  Enter the category name"
        return textField
    }()
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Add to or Create Collection"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    init(_ dataPersistence: DataPersistence<Category>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setupCancelButtonConstraints()
        setupDoneButtonConsgtraints()
        collectionView.collectionView.dataSource = self
        collectionView.collectionView.delegate = self
        categoryTextField.delegate = self
        collectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionsCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed))
        loadCategoriesFromDataPersistence()
    }
    
    private func loadCategories() {
        if let category = createdCategory {
            self.createdCategory = category
            categoryTextField.text = category.name
            categorytState = .existingCategory
        } else {
            categorytState = .newCategory
        }
    }
    
    private func loadCategoriesFromDataPersistence(){
        do {
            categories = try dataPersistence.loadItems()
        } catch{
            showAlert(title: "Loading error", message: "Error: \(error)")
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
        
        let category = Category(name: categoryTextField.text ?? "Category Name", image: imageData!, savedVenue: nil)
        showAlert(title: nil, message: "Do you want to add a new category?") { (alertaction) in
            if alertaction.style == .default{
                if self.dataPersistence.hasItemBeenSaved(category){
                    self.showAlert(title: "Dupicated Categories", message: "You can not add duplicate categories to this collection: \(category.name)")
                } else {
                    do {
                        // save to documents directory
                        try self.dataPersistence.createItem(category)
                        self.showAlert(title: "Item was added", message: "Category: \(category.name) was added to your collection")
                    } catch {
                        self.showAlert(title: "Saving error", message: "Error: \(error)")
                    }
                }
                self.viewPopsDown()
                //self.categories.append(category)
            } else if alertaction.style == .cancel {
                self.viewPopsDown()
            }
        }
        
        //todo: we have to check to see if the category has been saved
        //categories.append(category)
    }
    
    @objc func cancelButtonPressed() {
        viewPopsDown()
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
    
    private func setupCancelButtonConstraints() {
        containerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07),
            cancelButton.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.15)
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
        cell.delegate = self
        
        let category = categories[indexPath.row]
        cell.configureCell(category: category, viewcontroller: CollectionsViewController.self)
        
        return cell
    }
}

extension CollectionsViewController:CollectionsViewCellDelegate{
    func collectionCellAddedVenue(_ cell: CollectionViewCell, oldCategory: Category, venue: SavedVenue) {
        
    }
    
    func didLongPress(_ cell: CollectionViewCell) {
        guard let indexPath = collectionView.collectionView.indexPath(for: cell)  else { return }
        
        deleteCategory(indexPath: indexPath)
    }
    
    @objc private func deleteCategory(indexPath: IndexPath){
        print("DELETE")
        dataPersistence.synchronize(categories)
            
            do {
                categories = try dataPersistence.loadItems()
            } catch {
                showAlert(title: "Failed to load categories to delete", message: "\(error)")
            }
            
        categories.remove(at: indexPath.row)
    //        collectionView.deleteItems(at: [indexPath])
            
            do{
                try dataPersistence.deleteItem(at: indexPath.row)
            } catch {
                showAlert(title: "Deletion Error", message: "\(error)")
            }
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
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    
        guard let savedVenue = categories[indexPath.row].savedVenue else {
            return
        }
            
            
            let tableViewController = VenueTableViewController(savedVenue, dataPersistence)
            navigationController?.pushViewController(tableViewController, animated: true)
      }
}

extension CollectionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        createdCategory?.name = textField.text ?? "no event name"
        
        return true
    }
}

extension CollectionsViewController: DataPersistenceDelegate{
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCategoriesFromDataPersistence()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
         self.collectionView.collectionView.reloadData()
    }
    
    
}
