//
//  HomeInteractor.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

class HomeInteractor : HomeInteractorDelegate
{
    // MARK:- Properties
    
    var presenter: HomePresenterDelegate?
    private var networkManager: ForkifyNetworkManager
    private let suggestionsBox = SuggestionBox.open
    
    // MARK:- init
    
    init(networkManager: ForkifyNetworkManager = .init())
    {
        self.networkManager = networkManager
    }
    
    // MARK:- Methods
    
    func search(for key: String)
    {
        guard !key.isEmpty else{
            presenter?.didRecive(search: [])
            return
        }
        
        networkManager.search(for: key, completion: searchCallBack)
    }
    
    func getSuggestions(for key: String)
    {
        var suggestions: [String] = []
        if key.isEmpty
        {
            suggestions = suggestionsBox.getSuggestions()
        }
        else
        {
            suggestions = suggestionsBox.getSuggestions(for: key)
        }
        presenter?.didRecive(suggestions: suggestions)
    }
    
    func save(suggestion title: String)
    {
        suggestionsBox.add(title)
    }
    
    // MARK:- Helper
    
    private func searchCallBack(_ result: Result<SearchRespnse, Error>)
    {
        var recipes: [RecipeModel] = []
        
        if case let .success(response) = result,
           let results = response.recipes
        {
            recipes = results
        }
        
        presenter?.didRecive(search: recipes)
    }
}
