//
//  Networkable.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol Networkable
{
    associatedtype Target: RemoteTarget
    
    @discardableResult
    func request<Model: Decodable>(_ target: Target,
                                   completion: @escaping (Result<Model, Error>) -> Void) -> URLSessionDataTask?
    
    func asyncRequest<Model: Decodable>(_ target: Target) -> Result<Model, Error>
}
