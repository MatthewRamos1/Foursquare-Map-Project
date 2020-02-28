//
//  UIViewController+Extensions.swift
//  Foursquare-Map-Project
//
//  Created by Bienbenido Angeles on 2/27/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(title:String?, message: String?, completion: ((UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: completion)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: completion)
        alertVC.addAction(okButton)
        alertVC.addAction(cancelButton)
        present(alertVC, animated: true, completion: nil)
    }
}
