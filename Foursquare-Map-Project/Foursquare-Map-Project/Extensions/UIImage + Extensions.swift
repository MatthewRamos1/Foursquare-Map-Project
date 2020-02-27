//
//  UIImage + Extensions.swift
//  Foursquare-Map-Project
//
//  Created by Matthew Ramos on 2/26/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import NetworkHelper
import DataPersistence
 
extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIImageView {
    public func getImage1(with urlString: String,
                         writeTo directory: Directory = .cachesDirectory,
                         completion: @escaping (Result<UIImage, AppError>) -> ()) {
      
      // The UIActivityIndicatorView is used to indicate to the user that a download is in progre
      
      guard let url = URL(string: urlString) else {
        completion(.failure(.badURL(urlString)))
        return
      }
      
      // check the cache
      let filename = createComponentString1(from: url)
      if let cachedImage = cachedImage(for: filename, directory: directory) {
        completion(.success(cachedImage))
        return
      }
      
      let request = URLRequest(url: url)
      
      NetworkHelper.shared.performDataTask(with: request) { [weak self] (result) in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success(let data):
          if let image = UIImage(data: data) {
            // cache image to disk
            let componentStr = self?.createComponentString1(from: url) ?? ""
            self?.write1(to: directory, image: image, path: componentStr)
            
            completion(.success(image))
          }
        }
      }
    }
    
     private func createComponentString1(from url: URL) -> String {
        var componentStr = ""
        for component in url.pathComponents where component != "/" {
          componentStr += component
        }
        return componentStr
      }
    private func write1(to directory: Directory,
                       image: UIImage,
                       path: String) {
      let directoryURL = directory == .cachesDirectory ? FileManager.getCachesDirectory() : FileManager.getDocumentsDirectory()
      let filepath = directoryURL.appendingPathComponent(path)
      
      // convert image to data (png or jpg)
      let imageData = image.pngData()
      
      // write (save) to the caches directory
      try? imageData?.write(to: filepath)
    }
    }

