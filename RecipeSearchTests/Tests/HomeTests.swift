//
//  RecipeSearchTests.swift
//  RecipeSearchTests
//
//  Created by Mohamed Shemy on Sat 15 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchTests : XCTestCase
{
    // MARK:- Properties
    
    var interactor: HomeInteractor!
    var presenter: HomePresenter!
    var view: HomeViewTests!
    
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
    
    func testSearchForPizzaRecipes()
    {
        interactor.search(for: "pizza")
    }
    
    func testSavePizzaSuggestion()
    {
        interactor.save(suggestion: "pizza")
    }
    
    func testGetSuggestion()
    {
        interactor.getSuggestions(for: "pizza")
    }
}

class HomeViewTests : HomeViewDelegate
{
    var interactor: HomeInteractorDelegate?
    var router: RecipeRouter?
    
    func display(search results: HomeDataManager)
    {
        XCTAssert(!results.dataSource.isEmpty, "results should not be empty!")
    }
    
    func display(suggestions: [String])
    {
        if suggestions.isEmpty
        {
            XCTFail("suggestions should not be empty!")
        }
        else
        {
            XCTAssert(suggestions[0] == "pizza", "first suggestion should be pizza")
        }
    }
    
    func display(error message: Alert)
    {
        XCTFail(message.message)
    }
}
