//
//  HomePresenter.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

class HomePresenter : HomePresenterDelegate
{
    // MARK:- Properties
    
    weak var view: HomeViewDelegate?
    private var dataManager: HomeDataManager = .init([])
    
    // MARK:- Methods
    
    func didRecive(search results: [RecipeModel])
    {
        let recipes = results.compactMap(\.viewModel)
        dataManager = .init(recipes)
        view?.display(search: dataManager)
    }
    
    func didRecive(error message: Alert?)
    {
        view?.display(error: message ?? .tryAgain)
    }
}
