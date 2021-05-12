//
//  RecipeModel.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Mon 10 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

// MARK:- RecipeModel

struct RecipeModel : Codable
{
    let publisher,
        title,
        sourceURL,
        recipeID,
        imageURL,
        publisherURL: String?
    
    let socialRank: Double?
    
    enum CodingKeys: String, CodingKey
    {
        case publisher, title
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
    }
}

extension RecipeModel
{
    var viewModel: Recipe?
    {
        guard let publisher = publisher,
              let title = title,
              let sourceURL = sourceURL,
              let recipeID = recipeID,
              let imageURL = imageURL,
              let publisherURL = publisherURL,
              let socialRank = socialRank
        else { return nil }
        
        return .init(publisher: publisher, title: title,
                     sourceURL: sourceURL, recipeID: recipeID,
                     imageURL: imageURL, publisherURL: publisherURL, socialRank: socialRank)
    }
}

// MARK:- Recipe

struct Recipe
{
    let publisher,
        title,
        sourceURL,
        recipeID,
        imageURL,
        publisherURL: String
    
    let socialRank: Double
}
