//
//  RecipeDetailsPresenter.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Fri 14 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

class RecipeDetailsPresenter : RecipeDetailsPresenterDelegate
{
    // MARK:- Properties
    
    weak var view: RecipeDetailsViewDelegate?
    
    // MARK:- Methods
    
    func didRecive(recipe details: RecipeInfoModel)
    {
        if let details = details.viewModel
        {
            view?.display(recipe: details)
        }
        else
        {
            didRecive(error: .canNotLoadRecipeDetails)
        }
    }
    
    func didRecive(error message: Alert?)
    {
        view?.display(error: message ?? .tryAgain)
    }
}
