//
//  UIImageView+Extension.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, defaultImage : String?) {
        
        if let defaultImage = defaultImage {
            self.image = UIImage(named: defaultImage)
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let imageTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return }
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
        }
        imageTask.resume()
    }
}

