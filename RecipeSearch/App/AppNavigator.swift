//
//  AppNavigator.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class AppNavigator
{
    private var window: UIWindow?
    
    func go()
    {
        goHome()
    }
    
    private func setupAppRoot(as controller: UIViewController)
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func goHome()
    {
        let controller = HomeViewController.create()
        setupAppRoot(as: controller)
    }
}
