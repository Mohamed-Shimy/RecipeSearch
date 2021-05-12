//
//  HomeNavigator.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

enum HomeNavigator : Navigatable
{
    case recipeInfo(Recipe)
    
    var viewController: UIViewController
    {
        switch self
        {
            case let .recipeInfo(recipe):
                return UIViewController()
        }
    }
}
