//
//  UIApplecation + Navigation.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIApplication
{
    static var keyWindow: UIWindow
    {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first ??
            UIWindow(frame: UIScreen.main.bounds)
    }
    
    static func setRoot(controller: UIViewController)
    {
        let window = keyWindow
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
