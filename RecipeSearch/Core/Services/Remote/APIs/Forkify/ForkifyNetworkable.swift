//
//  ForkifyNetworkable.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol ForkifyNetworkable
{
    func search(for key: String, completion: @escaping (Result<SearchRespnse, Error>) -> Void)
    func getRecipeInfo(by id: String, completion: @escaping (Result<RecipeDetailsRespnse, Error>) -> Void)
}
