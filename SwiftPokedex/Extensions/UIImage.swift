//
//  UIImage.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

fileprivate var cancellables = Set<AnyCancellable>()

extension UIImage {
    static let pokedex = UIImage(named: "pokedex-icon")
    static let items = UIImage(named: "items-icon")

    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> Swift.Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
            let request = URLRequest(url: imageURL)

            let cache = URLCache.shared
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { $0 }
                    .sinkToResult { result in
                        switch result {
                        case let .success(response):
                            let image = UIImage(data: response.data)
                            let cachedImage = CachedURLResponse(response: response.response, data: response.data)
                            cache.storeCachedResponse(cachedImage, for: request)
                            
                            DispatchQueue.main.async { completion(image) }
                        case .failure:
                            DispatchQueue.main.async { completion(nil) }
                        }
                    }.store(in: &cancellables)
            }
        }
    }
}
