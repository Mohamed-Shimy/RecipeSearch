//
//  Int + Index.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Thu 13 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

extension Int
{
    func inRange<T>(of array: Array<T>) -> Bool
    {
        0..<array.count ~= self
    }
    
    func inRang(close s: Int, _ e: Int) -> Bool
    {
        guard s <= e else { return false }
        return s...e ~= self
    }
    
    func inRang(open s: Int, _ e: Int) -> Bool
    {
        guard s <= e else { return false }
        return s..<e ~= self
    }
}
