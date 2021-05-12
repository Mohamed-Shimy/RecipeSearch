//
//  UIViewController + Alerts.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Tue 11 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIViewController
{
    func showAlert(_ title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async
        { [weak self] in
            
            self?.present(alert,animated: true, completion: nil)
        }
    }
    
    func showAlert(_ title: Title, alert: Alert)
    {
        showAlert(title.rawValue, message: alert.message)
    }
    
    func display(error message: Alert)
    {
        showAlert(.app, alert: message)
    }
}
