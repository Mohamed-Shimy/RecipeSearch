//
//  Storyboard.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

enum Storyboard : String
{
    case home
    case recipeDetails
    
    var name: String
    {
        return rawValue.capitalizeFirst
    }
}
