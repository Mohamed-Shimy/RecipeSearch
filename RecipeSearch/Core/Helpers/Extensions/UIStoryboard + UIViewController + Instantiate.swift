//
//  UIStoryboard + UIViewController + Instantiate.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIStoryboard
{
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil)
    {
        self.init(name: storyboard.name, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T
    {
        let id = "\(T.self)"
        guard let viewController = self.instantiateViewController(withIdentifier: id) as? T else
        {
            fatalError("Couldn't instantiate view controller with identifier \(id) ")
        }
        
        return viewController
    }
}

extension UIViewController
{
    static func instantiate(storyboard: Storyboard) -> Self
    {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
}
