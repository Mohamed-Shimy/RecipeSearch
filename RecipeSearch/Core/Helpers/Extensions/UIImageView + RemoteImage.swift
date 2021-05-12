//
//  UIImageView + RemoteImage.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIImageView
{
    func setImage(from url: String, placeholder: UIImage = #imageLiteral(resourceName: "placeholder"))
    {
        ImageStore.open.image(url)
        { image in
            
            DispatchQueue.main.async
            { [weak self] in
                self?.image = image ?? placeholder
            }
        }
    }
}
