//
//  Collection.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Thu 13 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

extension Collection
{
    func choose(_ n: Int) -> [Element]
    {
        Array(shuffled().prefix(n))
    }
}
