//
//  Loader.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Mon 4 Jan 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol FileNameable
{
    var name: String { get }
}

enum RecipeDataFile : FileNameable
{
    case recipes
    case recipeInfo
    
    var name: String
    {
        switch self
        {
            case .recipes: return "PizzaRecipes"
            case .recipeInfo: return "Recipe47746"
        }
    }
}

func loadJSON<T: Decodable>(file: RecipeDataFile) -> T
{
    return load(name: file.name, withExtension: "json")
}

func loadJSON<T: Decodable>(file: FileNameable) -> T
{
    return load(name: file.name, withExtension: "json")
}

func loadJSONData(from file: RecipeDataFile) -> Data?
{
    return loadJSONData(from: file.name)
}

func loadJSONData(from file: FileNameable) -> Data?
{
    return loadJSONData(from: file.name)
}

func load<T: Decodable>(name: String, withExtension: String? = nil) -> T
{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: name, withExtension: withExtension) else {
        fatalError("Couldn't find \(name) in main bundle.")
    }
    
    do
    {
        data = try Data(contentsOf: file)
    }
    catch
    {
        fatalError("Couldn't load \(name) from main bundle:\n\(error)")
    }
    
    do
    {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch
    {
        fatalError("Couldn't parse \(name) as \(T.self):\n\(error)")
    }
}

func loadJSONData(from localJSONFileName: String) -> Data?
{
    do
        {
            guard let localFilePath = Bundle.main.path(forResource: localJSONFileName, ofType: "json") else {
                throw NSError(domain: "\(localJSONFileName).json", code: 404, userInfo: nil)
            }
            
            let jsonString = try NSString(contentsOfFile: localFilePath, encoding: String.Encoding.utf8.rawValue)
            let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue)!
            
            return jsonData
        }
    catch
    {
        return nil
    }
}
