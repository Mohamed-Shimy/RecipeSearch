//
//  RecipeDetailsInteractor.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Fri 14 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

class RecipeDetailsInteractor : RecipeDetailsInteractorDelegate
{
    // MARK:- Properties
    
    var presenter: RecipeDetailsPresenterDelegate?
    private var networkManager: ForkifyNetworkManager
    
    // MARK:- init
    
    init(networkManager: ForkifyNetworkManager = .init())
    {
        self.networkManager = networkManager
    }
    
    // MARK:- Methods
    
    func getDetails(with id: String)
    {
        networkManager.getRecipeInfo(by: id, completion: detailsCallBack)
    }
    
    // MARK:- Helper
    
    private func detailsCallBack(_ result: Result<RecipeDetailsRespnse, Error>)
    {
        if case let .success(response) = result,
           let details = response.recipe
        {
            presenter?.didRecive(recipe: details)
        }
        else
        {
            presenter?.didRecive(error: .canNotLoadRecipeDetails)
        }
    }
}
