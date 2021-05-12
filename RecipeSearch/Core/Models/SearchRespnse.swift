//
//  SearchRespnse.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

struct SearchRespnse : Codable
{
    let count: Int?
    let recipes: [RecipeModel]?
}
