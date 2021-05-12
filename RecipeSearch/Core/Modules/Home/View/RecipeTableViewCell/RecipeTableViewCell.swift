//
//  RecipeTableViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class RecipeTableViewCell : ConfigurableTableCell
{
    @IBOutlet weak var recipeimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        recipeimageView.layer.cornerRadius = 8
        reset()
    }
    
    func configure(with item: Recipe, at indexPath: IndexPath)
    {
        recipeimageView.setImage(from: item.imageURL)
        titleLabel.text = item.title
        publisherLabel.text = item.publisher
    }
    
    private func reset()
    {
        recipeimageView.image = nil
        titleLabel.text = ""
        publisherLabel.text = ""
    }
}
