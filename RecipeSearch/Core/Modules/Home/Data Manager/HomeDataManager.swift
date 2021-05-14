//
//  HomeDataManager.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

typealias RecipeTableViewDataSource = TableViewDataManager<Recipe, RecipeTableViewCell>

class HomeDataManager : NSObject, UITableViewDelegate
{
    // MARK:- Properties
    
    private(set) var dataSource: RecipeTableViewDataSource
    weak var delegate: HomeDataManagerDelegate?
    
    // MARK:- init
    
    init(_ recipes: [Recipe])
    {
        dataSource = .init(recipes)
    }
    
    // MARK:- Methods
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource.item(at: indexPath.row)
        delegate?.didSelect(item, at: indexPath)
    }
}
