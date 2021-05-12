//
//  HomeViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Sun 9 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController
{
    // MARK:- Outlets
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK:- Properties
    
    var interactor: HomeInteractorDelegate?
    var router: HomeRouter?
    var dropDown = DropDown()
    
    // MARK:- ViewController LifeCycel
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Setup
    
    private func setup()
    {
        setupView()
        setSearchContainerViewAppearence()
        setupResultTableView()
        setupSearchTextField()
        setupDropDown()
    }
    
    private func setupView()
    {
        view.isUserInteractionEnabled = true
    }
    
    private func setSearchContainerViewAppearence()
    {
        searchContainerView.layer.cornerRadius = 8
        searchContainerView.layer.borderWidth = 1
        searchContainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupResultTableView()
    {
        resultTableView.tableFooterView = UIView()
        resultTableView.register(cellNib: RecipeTableViewCell.self)
    }
    
    private func setupSearchTextField()
    {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextDidChanged), for: .editingChanged)
    }
    
    func setupDropDown()
    {
        dropDown.delegate = self
    }
    
    // MARK:- Methods
    
    private func search(for key: String)
    {
        interactor?.search(for: key)
    }
    
    private func getSuggestions(for key: String) -> [String]
    {
        var items = suggestions.filter({ $0.lowercased().contains(key.lowercased()) })
        if items.isEmpty { items = suggestions }
        return items
    }
    
    private func displayDropDown(with items: [String])
    {
        if dropDown.isPresented
        {
            dropDown.update(items: items)
        }
        else
        {
            dropDown.show(items, on: searchContainerView)
        }
    }
    
    // MARK:- Actions
    
    @objc func searchTextDidChanged(_ textField: UITextField)
    {
        let key = textField.text!
        let items = getSuggestions(for: key)
        displayDropDown(with: items)
    }
}

// MARK:- UITextFieldDelegate

extension HomeViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let key = textField.text!
        let items = getSuggestions(for: key)
        displayDropDown(with: items)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

// MARK:- HomeViewDelegate

extension HomeViewController : HomeViewDelegate
{
    func display(search results: HomeDataManager)
    {
        results.delegate = self
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.resultTableView.dataSource = results.dataSource
            self?.resultTableView.delegate = results
            self?.resultTableView.reloadData()
        }
    }
}

// MARK:- HomeDataManagerDelegate

extension HomeViewController : HomeDataManagerDelegate
{
    func didSelect(_ item: Recipe, at indexPath: IndexPath)
    {
        router?.navigate(to: .recipeInfo(item))
    }
}

// MARK:- DropDownDelegate

extension HomeViewController : DropDownDelegate
{
    func didSelect(_ item: String, at indexPath: IndexPath)
    {
        searchTextField.text = item
        searchTextField.resignFirstResponder()
        search(for: item)
    }
}

extension HomeViewController
{
    static func create() -> UIViewController
    {
        let view = Self.instantiate(storyboard: .home)
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter(view)
        
        presenter.view = view
        interactor.presenter = presenter
        view.interactor = interactor
        view.router = router
        
        return view
    }
}

let suggestions = [
 "carrot",
 "broccoli",
 "asparagus",
 "cauliflower",
 "corn",
 "cucumber",
 "green pepper",
 "lettuce",
 "mushrooms",
 "onion",
 "potato",
 "pumpkin",
 "red pepper",
 "tomato",
 "beetroot",
 "brussel sprouts",
 "peas",
 "zucchini",
 "radish",
 "sweet potato",
 "artichoke",
 "leek",
 "cabbage",
 "celery",
 "chili",
 "garlic",
 "basil",
 "coriander",
 "parsley",
 "dill",
 "rosemary",
 "oregano",
 "cinnamon",
 "saffron",
 "green bean",
 "bean",
 "chickpea",
 "lentil",
 "apple",
 "apricot",
 "avocado",
 "banana",
 "blackberry",
 "blackcurrant",
 "blueberry",
 "boysenberry",
 "cherry",
 "coconut",
 "fig",
 "grape",
 "grapefruit",
 "kiwifruit",
 "lemon",
 "lime",
 "lychee",
 "mandarin",
 "mango",
 "melon",
 "nectarine",
 "orange",
 "papaya",
 "passion fruit",
 "peach",
 "pear",
 "pineapple",
 "plum",
 "pomegranate",
 "quince",
 "raspberry",
 "strawberry",
 "watermelon",
 "salad",
 "pizza",
 "pasta",
 "popcorn",
 "lobster",
 "steak",
 "bbq",
 "pudding",
 "hamburger",
 "pie",
 "cake",
 "sausage",
 "tacos",
 "kebab",
 "poutine",
 "seafood",
 "chips",
 "fries",
 "masala",
 "paella",
 "som tam",
 "chicken",
 "toast",
 "marzipan",
 "tofu",
 "ketchup",
 "hummus",
 "chili",
 "maple syrup",
 "parma ham",
 "fajitas",
 "champ",
 "lasagna",
 "poke",
 "chocolate",
 "croissant",
 "arepas",
 "bunny chow",
 "pierogi",
 "donuts",
 "rendang",
 "sushi",
 "ice cream",
 "duck",
 "curry",
 "beef",
 "goat",
 "lamb",
 "turkey",
 "pork",
 "fish",
 "crab",
 "bacon",
 "ham",
 "pepperoni",
 "salami",
 "ribs"
 ]
