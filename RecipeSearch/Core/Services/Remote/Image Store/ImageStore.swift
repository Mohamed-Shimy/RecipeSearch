//
//  ImageStore.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

final class ImageStore
{
    typealias _ImageDictionary = [String: UIImage]
    fileprivate var images: _ImageDictionary = [:]
        
    static var open = ImageStore()
    
    func image(_ url: String, completion: @escaping (UIImage?) -> Void)
    {
        if let image = images[url]
        {
            completion(image)
        }
        else
        {
            downloadImage(from: url, completion: completion)
        }
    }
    
    private func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void)
    {
        Self.downloadImage(from: url)
        { [weak self] image in
            
            if let image = image
            {
                self?.images[url] = image
            }
            
            completion(image)
        }
    }
    
    static func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void)
    {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url)
        { data, _, _ in
            
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
