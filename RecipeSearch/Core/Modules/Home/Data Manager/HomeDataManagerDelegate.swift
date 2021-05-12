//
//  HomeDataManagerDelegate.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol HomeDataManagerDelegate : AnyObject
{
    func didSelect(_ item: Recipe, at indexPath: IndexPath)
}
