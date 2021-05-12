//
//  UIView + LayoutConstraint.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

extension UIView
{
    func setConstraints(to view: UIView, constants: UIEdgeInsets = .zero)
    {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constants.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constants.bottom),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constants.right)
        ])
    }
}
