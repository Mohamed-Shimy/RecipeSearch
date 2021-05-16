//
//  RecipeDetailsTests.swift
//  RecipeSearchTests
//
//  Created by Mohamed Shemy on Sun 16 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import XCTest

class RecipeDetailsTests: XCTestCase
{
    // MARK:- Properties
    
    var interactor: RecipeDetailsInteractor!
    var presenter: RecipeDetailsPresenter!
    var view: RecipeDetailsViewTests!
    
    // MARK:- Test Life Cycel
    
    override func setUp()
    {
        interactor = .init(networkManager: .init(isLive: false))
        presenter = .init()
        view = .init()
        
        presenter.view = view
        interactor.presenter = presenter
    }
    
    override func tearDown()
    {
        view = nil
        presenter = nil
        interactor = nil
    }
    
    // MARK:- Test Methods
    
    func testGettingBestPizzaDoughEverRecipeDetails()
    {
        interactor.getDetails(with: "47746")
    }
}

class RecipeDetailsViewTests : RecipeDetailsViewDelegate
{
    var interactor: RecipeDetailsInteractorDelegate?
    var router: RecipeRouter?
    
    func display(recipe details: RecipeInfo)
    {
        let id = "47746"
        let publisher = "101 Cookbooks"
        let title = "Best Pizza Dough Ever"
        
        XCTAssert(details.recipeID == id, "ID should be '\(id)'")
        XCTAssert(details.title == title, "title should be '\(title)'")
        XCTAssert(details.publisher == publisher, "publisher should be '\(publisher)'")
    }
    
    func display(error message: Alert)
    {
        XCTFail(message.message)
    }
}
