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
    case recipeDetails(Recipe)
    
    var viewController: UIViewController
    {
        switch self
        {
            case let .recipeDetails(recipe):
                return UIViewController()
        }
    }
}
