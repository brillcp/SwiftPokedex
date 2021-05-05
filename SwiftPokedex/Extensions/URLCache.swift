//
//  URLCache.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import UIKit

extension URLCache {
    
    func cacheImage(from output: URLSession.DataTaskPublisher.Output, for request: URLRequest) {
        let cachedImage = CachedURLResponse(response: output.response, data: output.data)
        storeCachedResponse(cachedImage, for: request)
    }
    
    func image(from request: URLRequest) -> UIImage? {
        guard let data = URLCache.shared.cachedResponse(for: request)?.data,
              let image = UIImage(data: data)
        else { return nil }
        
        return image
    }
}
