//
//  RecipeDetailsViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Thu 13 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailsViewController : UIViewController
{
    // MARK:- Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    // MARK:- Properties
    
    var interactor: RecipeDetailsInteractorDelegate?
    var router: RecipeRouter?
    var recipe: Recipe!
    private var sourcePageLink = ""
    
    // MARK:- View Controller LifeCycel
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        getRecipeDetails()
    }
    
    // MARK:- Setup
    
    private func setup()
    {
        setupActivityIndicator()
        setupRecipeImageView()
    }
    
    private func setupActivityIndicator()
    {
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.stopAnimating()
    }
    
    private func setupRecipeImageView()
    {
        recipeImageView.layer.cornerRadius = 8
    }
    
    // MARK:- Methods
    
    func networkActivity(_ status: RequestStatus)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            switch status
            {
                case .loading, .populating: self?.startLoading()
                case .finish: self?.stopLoading()
            }
        }
    }
    
    private func startLoading()
    {
        view.alpha = 0.5
        activityIndicator.startAnimating()
    }
    
    private func stopLoading()
    {
        view.alpha = 1
        activityIndicator.stopAnimating()
    }
    
    private func getRecipeDetails()
    {
        guard recipe != nil else { return }
        
        interactor?.getDetails(with: recipe.recipeID)
    }
    
    private func setRecipeBasicInfo()
    {
        guard recipe != nil else { return }
        
        recipeImageView.setImage(from: recipe.imageURL)
        recipeTitleLabel.text = recipe.title
    }
    
    private func setRecipe(details: RecipeInfo)
    {
        sourcePageLink = details.sourceURL
        recipeImageView.setImage(from: details.imageURL)
        recipeTitleLabel.text = details.title
        setIngredients(details.ingredients)
    }
    
    private func setIngredients(_ ingredients: [String])
    {
        for ingredient in ingredients
        {
            let label = createLabel(with: "• \(ingredient)")
            ingredientsStackView.addArrangedSubview(label)
        }
    }
    
    private func createLabel(with title: String) -> UILabel
    {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = title
        label.numberOfLines = 0
        return label
    }
    
    // MARK:- Actions
    
    @IBAction func linkButtonDidTapped(_ sender: UIButton)
    {
        if let url = URL(string: sourcePageLink)
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.router?.present(destination: .recipeSourcePage(url))
            }
        }
    }
}

// MARK:- RecipeDetailsViewDelegate

extension RecipeDetailsViewController : RecipeDetailsViewDelegate
{
    func display(recipe details: RecipeInfo)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.setRecipe(details: details)
        }
    }
}

extension RecipeDetailsViewController
{
    static func create(_ recipe: Recipe) -> UIViewController
    {
        let view = RecipeDetailsViewController.instantiate(storyboard: .recipeDetails)
        let presenter = RecipeDetailsPresenter()
        let interactor = RecipeDetailsInteractor(networkManager: .init(activity: view.networkActivity))
        let router = RecipeRouter(view)
        
        view.recipe = recipe
        presenter.view = view
        interactor.presenter = presenter
        view.interactor = interactor
        view.router = router
        
        return view
    }
}
