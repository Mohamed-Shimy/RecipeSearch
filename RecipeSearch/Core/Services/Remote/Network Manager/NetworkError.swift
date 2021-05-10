//
//  NetworkError.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

enum NetworkError : Error, LocalizedError, CustomStringConvertible
{
    case missingURL
    case noData
    case cannotParseData
    case unknown(String)
    
    var description: String
    {
        switch self
        {
            case .missingURL: return "URL is missings!"
            case .noData: return "No data!"
            case .cannotParseData: return "Cannot parse data!"
            case let .unknown(message): return message
        }
    }
    
    var errorDescription: String? { description }
    
    init(_ error: Error)
    {
        let error = error as NSError
        self = .unknown(error.localizedDescription)
    }
}

/*
 public init(_ error: Error)
 {
 let error: NSError = error as NSError
 if error.domain == NSURLErrorDomain
 {
 switch error.code
 {
 case NSURLErrorResourceUnavailable:
 self = .noData
 case NSURLErrorNotConnectedToInternet:
 self = .noConnection
 case NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData, NSURLErrorCannotParseResponse:
 self = .parsingJSONError
 default:
 self = .unknownError(message: error.localizedDescription)
 }
 return
 }
 
 self = .unknownError(message: nil)
 }
 */
