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

            let cache = URLCache.shared
            let request = URLRequest(url: imageURL)

            if let image = cache.image(from: request) {
                DispatchQueue.main.async { completion(image) }
            } else {
                URLSession.shared.dataTaskPublisher(for: request).tryMap { $0 }.sinkToResult { result in
                    switch result {
                    case let .success(output):
                        cache.cacheImage(from: output, for: request)
                        DispatchQueue.main.async { completion( UIImage(data: output.data)) }
                    case .failure:
                        DispatchQueue.main.async { completion(nil) }
                    }
                }.store(in: &cancellables)
            }
        }
    }
}
