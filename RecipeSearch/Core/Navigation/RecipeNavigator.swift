//
//  RecipeNavigator.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit
import SafariServices

enum RecipeNavigator : Navigatable
{
    case recipeDetails(Recipe)
    case recipeSourcePage(URL)
    
    var viewController: UIViewController
    {
        switch self
        {
            case let .recipeDetails(recipe):
                return RecipeDetailsViewController.create(recipe)
                
            case let .recipeSourcePage(url):
                return SFSafariViewController(url: url)
        }
    }
}
