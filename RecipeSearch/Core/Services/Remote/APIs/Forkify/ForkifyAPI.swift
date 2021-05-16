//
//  ForkifyAPI.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

enum ForkifyAPI
{
    case search(for: String)
    case getRecipeInfo(by: String)
}

extension ForkifyAPI : RemoteTarget
{
    var baseURL: URL
    {
        let base = "https://forkify-api.herokuapp.com/api"
        return URL(string: base)!
    }
    
    var path: String
    {
        switch self
        {
            case .search: return "search"
            case .getRecipeInfo: return "get"
        }
    }
    
    var method: HTTPMethod
    {
        .get
    }
    
    var sampleData: Data
    {
        var data: Data?
        switch self
        {
            case .search: data = loadJSONData(from: .recipes)
            case .getRecipeInfo: data = loadJSONData(from: .recipeInfo)
        }
        return data ?? Data()
    }
    
    var headers: [String : String]?
    {
        [:]
    }
    
    var task: Task
    {
        switch self
        {
            case let .search(key):
                let params = ["q": key]
                return .withParameters(params, encoding: URLEncoding.default)
                
            case let .getRecipeInfo(id):
                let params = ["rId": id]
                return .withParameters(params, encoding: URLEncoding.default)
        }
    }
}
