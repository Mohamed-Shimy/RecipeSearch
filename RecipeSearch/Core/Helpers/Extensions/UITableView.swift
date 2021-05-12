//
//  UITableView.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UITableView
{
    // MARK:- Register
    
    func register<T>(cellNib: T.Type) where T: UITableViewCell
    {
        let id = "\(cellNib)"
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }
    
    func register<T>(cellClass: T.Type) where T: UITableViewCell
    {
        let id = "\(cellClass)"
        register(cellClass, forCellReuseIdentifier: id)
    }
    
    // MARK:- Dequeue
    
    func dequeue<Cell: UITableViewCell>() -> Cell
    {
        let id = "\(Cell.self)"
        guard let cell = dequeueReusableCell(withIdentifier: id) as? Cell
        else { fatalError("Cannot dequeue reusable cell with identifier '\(id)'") }
        return cell
    }
}
