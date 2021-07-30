//
//  UIImageView_Extension.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

extension UIImageView {
    
    // MARK: - Method Fetch Image / get Cached Image
    func getImageFromURL(imageURL: String?) {
        
        guard let imageURL = imageURL,
              let url = URL(string: imageURL) else { return }
        
        let imageCache = NSCache<NSString, UIImage>()
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "error_image")
                        self.contentMode = .scaleAspectFill
                    }
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    }
                }
                
            }.resume()
        }
        
    }
    
}
