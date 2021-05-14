//
//  RecipeRouter.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class RecipeRouter : Navigator
{
    typealias Destination = RecipeNavigator
    
    // MARK:- Properties
    
    weak var viewController: UIViewController?
    
    // MARK:- init
    
    init(_ view: UIViewController)
    {
        viewController = view
    }
}
