//
//  Navigator.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

protocol Navigator
{
    associatedtype Destination: Navigatable
    
    var viewController: UIViewController? { get }
    
    func dismiss()
    func navigate(to destination: Destination)
    func present(destination: Destination)
    func setRoot(_ destination: Destination, withNavigation: Bool)
}

extension Navigator
{
    func dismiss()
    {
        viewController?.dismiss(animated: true)
    }
    
    func navigate(to controller: Destination)
    {
        viewController?.push(navigatable: controller)
    }
    
    func present(destination: Destination)
    {
        viewController?.present(navigatable: destination)
    }
    
    func setRoot(_ destination: Self.Destination, withNavigation: Bool = true)
    {
        if withNavigation
        {
            let navigationController = UINavigationController(rootViewController: destination.viewController)
            UIApplication.setRoot(controller: navigationController)
        }
        else
        {
            UIApplication.setRoot(controller: destination.viewController)
        }
    }
}
