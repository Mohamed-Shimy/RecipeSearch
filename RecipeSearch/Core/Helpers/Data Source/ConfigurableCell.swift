//
//  ConfigurableCell.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

protocol ConfigurableCell : AnyObject
{
    associatedtype Model
    
    func configure(with item: Model, at indexPath: IndexPath)
}

typealias ConfigurableTableCell = UITableViewCell & ConfigurableCell
typealias ConfigurableCollectionCell = UICollectionViewCell & ConfigurableCell
