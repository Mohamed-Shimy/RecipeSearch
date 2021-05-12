//
//  AppDelegate.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Sun 9 May 2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    private var navigator: AppNavigator = .init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        navigator.go()
        return true
    }
}

