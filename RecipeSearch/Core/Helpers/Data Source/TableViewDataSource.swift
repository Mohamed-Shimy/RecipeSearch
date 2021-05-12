//
//  TableViewDataSource.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class TableViewDataManager<Model, Cell: ConfigurableTableCell> : NSObject, UITableViewDataSource where Cell.Model == Model
{
    // MARK:- Properties
    
    private(set) var items: [Model]
    
    var isEmpty: Bool { items.isEmpty }
    var count: Int { items.count }
    
    // MARK:- init
    
    init(_ items: [Model])
    {
        self.items = items
    }
    
    // MARK:- Methods
    
    // MARK: Indexing
    
    func item(at index: Int) -> Model
    {
        items[index]
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: Cell = tableView.dequeue()
        let item = item(at: indexPath.row)
        cell.configure(with: item, at: indexPath)
        return cell
    }
}
