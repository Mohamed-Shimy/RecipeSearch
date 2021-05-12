//
//  UIViewController + Navigator.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIViewController
{
    func present(navigatable: Navigatable, animated: Bool = true)
    {
        present(navigatable.viewController, animated: true, completion: nil)
    }
    
    func push(navigatable: Navigatable, animated: Bool = true)
    {
        navigationController?.pushViewController(navigatable.viewController, animated: animated)
    }
}
