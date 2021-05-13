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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        setupActivityIndicator()
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
    
    private func setupActivityIndicator()
    {
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.stopAnimating()
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
        resultTableView.alpha = 0.5
        activityIndicator.startAnimating()
    }
    
    private func stopLoading()
    {
        resultTableView.alpha = 1
        activityIndicator.stopAnimating()
    }
    
    private func search(for key: String)
    {
        interactor?.search(for: key)
    }
    
    private func getSuggestions(for key: String)
    {
        interactor?.getSuggestions(for: key)
    }
    
    private func save(suggestion title: String)
    {
        interactor?.save(suggestion: title)
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
        getSuggestions(for: key)
    }
}

// MARK:- UITextFieldDelegate

extension HomeViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let key = textField.text!
        getSuggestions(for: key)
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
    
    func display(suggestions: [String])
    {
        displayDropDown(with: suggestions)
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
        save(suggestion: item)
        search(for: item)
    }
}

extension HomeViewController
{
    static func create() -> UIViewController
    {
        let view = Self.instantiate(storyboard: .home)
        let presenter = HomePresenter()
        let interactor = HomeInteractor(networkManager: .init(activity: view.networkActivity))
        let router = HomeRouter(view)
        
        presenter.view = view
        interactor.presenter = presenter
        view.interactor = interactor
        view.router = router
        
        return view
    }
}
