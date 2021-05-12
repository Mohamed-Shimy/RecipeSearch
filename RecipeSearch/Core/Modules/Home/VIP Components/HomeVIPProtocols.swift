//
//  VIPProtocols.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

// MARK: View

protocol HomeViewDelegate : AnyObject
{
    var interactor: HomeInteractorDelegate? { get set }
    //var router: HomeRouter? { get set }
    
    func display(search results: HomeDataManager)
    func display(error message: Alert)
}

// MARK: Interactor

protocol HomeInteractorDelegate : AnyObject
{
    var presenter: HomePresenterDelegate? { get set }
    
    func search(for key: String)
}

// MARK: Presenter

protocol HomePresenterDelegate : AnyObject
{
    var view: HomeViewDelegate? { get set }
    
    func didRecive(search results: [RecipeModel])
    func didRecive(error message: Alert?)
}
