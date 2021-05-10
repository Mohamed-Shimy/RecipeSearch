//
//  Extension.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

extension URLRequest
{
    var method: HTTPMethod?
    {
        get { httpMethod.flatMap(HTTPMethod.init) }
        set { httpMethod = newValue?.rawValue }
    }
    
    var headers: [String: String]
    {
        get { allHTTPHeaderFields ?? [:] }
        set { allHTTPHeaderFields = newValue }
    }
}

extension URLRequest
{
    init(_ url: URL, method: HTTPMethod, headers: [String: String]? = nil)
    {
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
    
    init(target: RemoteTarget) throws
    {
        let url = target.baseURL.appendingPathComponent(target.path)
        self.init(url, method: target.method, headers: target.headers)
        
        let (parms, encoding) = target.task.value
        self = try encoding.encode(self, with: parms)
    }
}
