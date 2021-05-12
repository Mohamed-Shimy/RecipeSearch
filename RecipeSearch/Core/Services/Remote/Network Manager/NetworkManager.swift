//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Mohamed Shemy on Sun 12 Apr 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

typealias NetworkActivity = ((RequestStatus) -> Void)?

class NetworkManager<Target: RemoteTarget> : Networkable
{
    // MARK: Properites
    
    private var session = URLSession.shared
    private var activity: NetworkActivity
    private(set) var isLive: Bool = false
    
    // MARK: init
    
    init(isLive: Bool = true, activity: NetworkActivity = nil)
    {
        self.isLive = isLive
        self.activity = activity
    }
    
    // MARK: Public Methods
    
    @discardableResult
    func request<Model: Decodable>(_ target: Target,
                                   completion: @escaping (Result<Model, Error>) -> Void) -> URLSessionDataTask?
    {
        if isLive
        {
            return remoteRequest(target, activity: activity, completion: completion)
        }
        
        activity?(.finish)
        localRequest(target, completion: completion)
        return nil
    }
    
    func asyncRequest<Model: Decodable>(_ target: Target) -> Result<Model, Error>
    {
        var result: Result<Model, Error>!
        let semaphore = DispatchSemaphore(value: 0)
        
        request(target)
        { (_result: Result<Model, Error>) in
            result = _result
            semaphore.signal()
        }
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    // MARK: Private Methods
    
    private func remoteRequest<Model: Decodable>(_ target: Target, activity: NetworkActivity,
                                                 completion: @escaping (Result<Model, Error>) -> Void) -> URLSessionDataTask?
    {
        guard let request = try? URLRequest(target: target) else { return nil }
        activity?(.loading)
        let task = session.dataTask(with: request)
        { [weak self] (data, response, error) in
            
            //print(response)
            print(Model.self)
            
            activity?(.populating)
            
            if let error = error { activity?(.finish); completion(.failure(NetworkError(error))) }
            guard let data = data
            else
            {
                activity?(.finish)
                completion(.failure(NetworkError.noData))
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            do
            {
                if let response: Model = try self?.decode(data: data)
                {
                    completion(.success(response))
                }
                else
                {
                    completion(.failure(NetworkError.cannotParseData))
                }
            }
            catch(let error)
            {
                completion(.failure(NetworkError(error)))
            }
            activity?(.finish)
        }
        task.resume()
        return task
    }
    
    private func localRequest<Model: Decodable>(_ target: Target, completion: @escaping (Result<Model, Error>) -> Void)
    {
        do
        {
            let response: Model = try decode(data: target.sampleData)
            completion(.success(response))
        }
        catch(let error)
        {
            completion(.failure(NetworkError(error)))
        }
    }
    
    private func decode<Model: Decodable>(data: Data) throws -> Model
    {
        do
        {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Model.self, from: data)
            return response
        }
        catch(let error)
        {
            throw error
        }
    }
}
