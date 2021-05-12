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
    
    // MARK:- init
    
    init(networkManager: ForkifyNetworkManager = .init())
    {
        self.networkManager = networkManager
    }
    
    // MARK:- Methods
    
    func search(for key: String)
    {
        networkManager.search(for: key)
        { [weak self] result in
            
            switch result
            {
                case let .success(results):
                    self?.presenter?.didRecive(search: results)
                    
                case .failure:
                    self?.presenter?.didRecive(error: .canNotFindRecipe(key))
            }
        }
    }
}
