//
//  Alerts.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

enum Alert
{
    case canNotFindRecipe(String)
    case canNotLoadRecipeDetails
    
    case tryAgain
    case unkown(String?)
    
    var message: String
    {
        switch self
        {
            case let .canNotFindRecipe(name):
                return "Cann't find recipe '\(name)'"
                
            case .canNotLoadRecipeDetails:
                return "Cannot load recipe details"
                
            case .tryAgain:
                return "Something wrong, please try again!"
                
            case let .unkown(error):
                return error ?? Self.tryAgain.message
        }
    }
}
