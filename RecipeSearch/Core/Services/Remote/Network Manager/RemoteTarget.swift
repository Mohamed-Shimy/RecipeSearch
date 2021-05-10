//
//  RemoteTarget.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

// MARK: - RemoteTarget

protocol RemoteTarget
{
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var sampleData: Data { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

// MARK: - HTTPMethod

struct HTTPMethod: RawRepresentable, Equatable, Hashable
{
    static let connect = HTTPMethod(rawValue: "CONNECT")
    static let delete = HTTPMethod(rawValue: "DELETE")
    static let get = HTTPMethod(rawValue: "GET")
    static let head = HTTPMethod(rawValue: "HEAD")
    static let options = HTTPMethod(rawValue: "OPTIONS")
    static let patch = HTTPMethod(rawValue: "PATCH")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")
    static let trace = HTTPMethod(rawValue: "TRACE")
    
    let rawValue: String
    
    init(rawValue: String)
    {
        self.rawValue = rawValue
    }
}

// MARK: - Task

enum Task
{
    case plain
    case withParameters(_ parameters: [String: Any], encoding: ParameterEncoding)
    
    var value: ([String: Any], ParameterEncoding)
    {
        switch self
        {
            case .plain: return ([:], URLEncoding.default)
            case let .withParameters(parameters, encoding): return (parameters, encoding)
        }
    }
}
