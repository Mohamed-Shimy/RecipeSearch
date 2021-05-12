//
//  ForkifyNetworkManager.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

struct ForkifyNetworkManager : ForkifyNetworkable
{
    // MARK: Properties
    
    private let manager: NetworkManager<ForkifyAPI>
    
    // MARK: Init
    
    init(isLive: Bool = true, activity: NetworkActivity = nil)
    {
        manager = .init(isLive: isLive, activity: activity)
    }
    
    // MARK: Method
    
    func search(for key: String, completion: @escaping (Result<SearchRespnse, Error>) -> Void)
    {
        manager.request(.search(for: key), completion: completion)
    }
    
    func getRecipeInfo(by id: String, completion: @escaping (Result<RecipeInfoModel, Error>) -> Void)
    {
        manager.request(.getRecipeInfo(by: id), completion: completion)
    }
}
