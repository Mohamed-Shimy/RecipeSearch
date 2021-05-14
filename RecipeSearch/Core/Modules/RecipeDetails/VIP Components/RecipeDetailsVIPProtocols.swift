//
//  RecipeDetailsVIPProtocols.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Fri 14 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

// MARK: View

protocol RecipeDetailsViewDelegate : AnyObject
{
    var interactor: RecipeDetailsInteractorDelegate? { get set }
    var router: RecipeRouter? { get set }
    
    func display(recipe details: RecipeInfo)
    func display(error message: Alert)
}

// MARK: Interactor

protocol RecipeDetailsInteractorDelegate : AnyObject
{
    var presenter: RecipeDetailsPresenterDelegate? { get set }
    
    func getDetails(with id: String)
}

// MARK: Presenter

protocol RecipeDetailsPresenterDelegate : AnyObject
{
    var view: RecipeDetailsViewDelegate? { get set }
    
    func didRecive(recipe details: RecipeInfoModel)
    func didRecive(error message: Alert?)
}
