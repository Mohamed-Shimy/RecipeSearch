//
//  RecipeInfoModel.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Mon 10 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

// MARK:- RecipeInfoModel

struct RecipeInfoModel : Codable
{
    let publisher,
        sourceURL,
        recipeID,
        imageURL,
        socialRank,
        publisherURL,
        title: String?
    
    let ingredients: [String]?
    
    enum CodingKeys: String, CodingKey
    {
        case publisher, ingredients, title
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
    }
}

extension RecipeInfoModel
{
    var viewModel: RecipeInfo?
    {
        guard let publisher = publisher,
              let sourceURL = sourceURL,
              let recipeID = recipeID,
              let imageURL = imageURL,
              let socialRank = socialRank,
              let publisherURL = publisherURL,
              let title = title
        else { return  nil }
        
        return .init(publisher: publisher, sourceURL: sourceURL,
                     recipeID: recipeID, imageURL: imageURL, socialRank: socialRank,
                     publisherURL: publisherURL, title: title, ingredients: ingredients ?? [])
    }
}

// MARK:- RecipeInfo

struct RecipeInfo
{
    let publisher,
        sourceURL,
        recipeID,
        imageURL,
        socialRank,
        publisherURL,
        title: String
    
    let ingredients: [String]
}
