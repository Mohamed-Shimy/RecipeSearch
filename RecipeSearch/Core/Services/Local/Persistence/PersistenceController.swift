//
//  PersistenceController.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Thu 13 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import CoreData

struct PersistenceController
{
    let container: NSPersistentContainer
    
    init(_ name: String, inMemory: Bool = false)
    {
        container = NSPersistentContainer(name: name)
        if inMemory
        {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _,_ in  } //(storeDescription, error)
    }
    
    @discardableResult
    func save() -> Bool
    {
        if container.viewContext.hasChanges
        {
            do
            {
                try container.viewContext.save()
            }
            catch
            {
                return false
            }
        }
        
        return true
    }
}

extension PersistenceController
{
    static var suggestion: Self = .init("SuggestionModel")
}
