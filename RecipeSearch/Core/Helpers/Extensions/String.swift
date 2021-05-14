//
//  String.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Fri 14 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

extension String
{
    var capitalizeFirst: String
    {
        return prefix(1).capitalized + dropFirst()
    }
}
