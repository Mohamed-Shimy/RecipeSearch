//
//  Encoding.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

/* Referance https://github.com/Moya/Moya */

import Foundation

// MARK:- ParameterEncoding

protocol ParameterEncoding
{
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
}

// MARK:- URLEncoding

struct URLEncoding: ParameterEncoding
{
    enum Destination
    {
        case methodDependent
        case queryString
        case httpBody
        
        func encodesParametersInURL(for method: HTTPMethod) -> Bool
        {
            switch self
            {
                case .methodDependent: return [.get, .head, .delete].contains(method)
                case .queryString: return true
                case .httpBody: return false
            }
        }
    }
    
    enum ArrayEncoding
    {
        case brackets
        case noBrackets
        
        func encode(key: String) -> String
        {
            switch self
            {
                case .brackets: return "\(key)[]"
                case .noBrackets: return key
            }
        }
    }
    
    enum BoolEncoding
    {
        case numeric
        case literal
        
        func encode(value: Bool) -> String
        {
            switch self
            {
                case .numeric: return value ? "1" : "0"
                case .literal: return value ? "true" : "false"
            }
        }
    }
    
    
    static var `default`: URLEncoding { URLEncoding() }
    static var queryString: URLEncoding { URLEncoding(destination: .queryString) }
    static var httpBody: URLEncoding { URLEncoding(destination: .httpBody) }
    
    let destination: Destination
    let arrayEncoding: ArrayEncoding
    let boolEncoding: BoolEncoding
    
    init(destination: Destination = .methodDependent,
         arrayEncoding: ArrayEncoding = .brackets,
         boolEncoding: BoolEncoding = .numeric) {
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }
    
    // MARK: Encoding
    
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
    {
        var urlRequest = urlRequest
        guard let parameters = parameters else { return urlRequest }
        
        if let method = urlRequest.method, destination.encodesParametersInURL(for: method)
        {
            guard let url = urlRequest.url
            else { throw NetworkError.missingURL }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty
            {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        }
        else
        {
            if urlRequest.headers["Content-Type"] == nil
            {
                urlRequest.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
            }
            urlRequest.httpBody = Data(query(parameters).utf8)
        }
        
        return urlRequest
    }
    
    func queryComponents(fromKey key: String, value: Any) -> [(String, String)]
    {
        var components: [(String, String)] = []
        switch value
        {
            case let dictionary as [String: Any]:
                for (nestedKey, value) in dictionary
                {
                    components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
                }
                
            case let array as [Any]:
                for value in array
                {
                    components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
                }
                
            case let bool as Bool: components.append((escape(key), escape(boolEncoding.encode(value: bool))))
            default: components.append((escape(key), escape("\(value)")))
        }
        return components
    }
    
    func escape(_ string: String) -> String
    {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
    }
    
    private func query(_ parameters: [String: Any]) -> String
    {
        var components: [(String, String)] = []
        for key in parameters.keys.sorted(by: <)
        {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}

// MARK:- JSONEncoding

struct JSONEncoding: ParameterEncoding
{
    static var `default`: JSONEncoding { JSONEncoding() }
    static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }
    let options: JSONSerialization.WritingOptions
    
    init(options: JSONSerialization.WritingOptions = [])
    {
        self.options = options
    }
    
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
    {
        var urlRequest = urlRequest
        guard let parameters = parameters else { return urlRequest }
        
        do
        {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            if urlRequest.headers["Content-Type"] == nil
            {
                urlRequest.headers["Content-Type"] = "application/json"
            }
            urlRequest.httpBody = data
        }
        catch(let error)
        {
            throw NetworkError(error)
        }
        
        return urlRequest
    }
    
    func encode(_ urlRequest: URLRequest, withJSONObject jsonObject: Any? = nil) throws -> URLRequest
    {
        var urlRequest = urlRequest
        guard let jsonObject = jsonObject else { return urlRequest }
        
        do
        {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
            if urlRequest.headers["Content-Type"] == nil
            {
                urlRequest.headers["Content-Type"] = "application/json"
            }
            urlRequest.httpBody = data
        }
        catch(let error)
        {
            throw NetworkError(error)
        }
        
        return urlRequest
    }
}
