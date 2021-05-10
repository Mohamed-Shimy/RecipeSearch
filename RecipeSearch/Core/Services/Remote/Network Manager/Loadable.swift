//
//  Loadable.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol Loadable : AnyObject
{
    var isLoading: Bool{ get set }
    func activity(_ status: RequestStatus)
}

extension Loadable
{
    func activity(_ status: RequestStatus)
    {
        DispatchQueue.main.async
        {
            self.isLoading = status != .finish
        }
    }
}
