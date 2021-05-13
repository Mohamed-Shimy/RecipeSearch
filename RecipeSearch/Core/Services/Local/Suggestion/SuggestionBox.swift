//
//  SuggestionBox.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Thu 13 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import CoreData

final class SuggestionBox
{
    typealias Suggestions = [Suggestion]
    
    // MARK:- Properties
    
    static let open = SuggestionBox()
    
    private var suggestions: Suggestions = []
    private var suggestionsLimit = 10
    private let persistenceController = PersistenceController.suggestion
    private var context: NSManagedObjectContext { persistenceController.container.viewContext }
    
    // MARK:- init
    
    private init()
    {
        fetchData()
    }
    
    // MARK:- Public Methods
    
    // MARK: Suggestion Methods
    
    func getSuggestions(with limit: Int = 10) -> [String]
    {
        let suggestions = suggestions
            .prefix(limit)
            .compactMap(\.title)
        
        return suggestions.isEmpty ? available.choose(limit) : suggestions
    }
    
    func getSuggestions(for key: String) -> [String]
    {
        available.filter { $0.lowercased().contains(key.lowercased()) }
    }
    
    // MARK: Data Actions
    
    @discardableResult
    func add(_ title: String) -> Bool
    {
        deleteIfExist(title)
        deleteOverflowIfExist(title)
        
        addNew(title)
        return saveAndFetch()
    }

    @discardableResult
    func delete(at index: Int) -> Bool
    {
        guard index.inRange(of: suggestions) else { return false }
        let suggestion = suggestions[index]
        return delete(suggestion)
    }
    
    @discardableResult
    func delete(_ suggestion: Suggestion) -> Bool
    {
        context.delete(suggestion)
        return saveAndFetch()
    }
    
    // MARK: Private Methods
    
    private func addNew(_ title: String)
    {
        let suggestion = Suggestion(context: context)
        suggestion.title = title
        context.insert(suggestion)
    }
    
    private func deleteIfExist(_ title: String)
    {
        if let suggestion = suggestions.first(where: { $0.title == title})
        {
            delete(suggestion)
        }
    }
    
    private func deleteOverflowIfExist(_ title: String)
    {
        if suggestions.count >= suggestionsLimit
        {
            delete(suggestions.last!)
        }
    }
    
    private func fetchData()
    {
        let fetchRequest: NSFetchRequest<Suggestion> = Suggestion.fetchRequest()
        do
        {
            suggestions = try context.fetch(fetchRequest).reversed()
        }
        catch
        {
            suggestions = []
        }
    }
    
    @discardableResult
    private func saveAndFetch() -> Bool
    {
        let isSaved = persistenceController.save()
        fetchData()
        return isSaved
    }
    
    private func clearData()
    {
        for i in 0..<suggestions.count
        {
            delete(at: i)
        }
    }
}

extension SuggestionBox
{
    var available: [String]
    {
        [
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
    }
}
