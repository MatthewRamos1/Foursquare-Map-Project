//
//  AddCollectionsView.swift
//  Foursquare-Map-Project
//
//  Created by Oscar Victoria Gonzalez  on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class AddCollectionsView: UIView {
    
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Enter a collection title"
        return textField
    }()
    
    public lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Leave a tip"
        return label
    }()
    
    public lazy var tipTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        return textView
    }()
    
    //hidden nav
    
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
        return button
      }()
       
      public lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
         
        return button
      }()
    
    public lazy var stackLabel: UILabel = {
        let label = UILabel()
        label.text = "Add or create collection"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        return buttonStack
      }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureButtonStackView()
        configureTextField()
        configureLabel()
        configureTipTextView()
        configureCollectionView()
    }
    
    func configureButtonStackView() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(stackLabel)
        buttonStackView.addArrangedSubview(saveButton)
         
       // buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 30
         
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        stackLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
          buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
          buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
          buttonStackView.heightAnchor.constraint(equalToConstant: 50)
           
        ])
      }
    
    private func configureTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureLabel(){
        addSubview(tipLabel)
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            tipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    private func configureTipTextView(){
        addSubview(tipTextView)
        tipTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipTextView.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 8),
            tipTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tipTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tipTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tipTextView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}



