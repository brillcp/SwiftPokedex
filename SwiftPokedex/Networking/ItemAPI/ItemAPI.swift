//
//  ItemAPI.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
//

import Foundation
import Combine

final class ItemAPI: API {
    
    // MARK: Public functions
    /*
    static func allItems(_ completion: @escaping (Result<[ItemDetails], Error>) -> Swift.Void) {
        requestItems(limit: 450)?.flatMap { response in
            Publishers.Sequence(sequence: response.results.compactMap { itemDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sink { result in
            completion(result)
        }.store(in: &cancellables)
    }
     */
}

// MARK: -
extension ItemAPI {
    /*
    // MARK: Private functions
    private static func itemDetails(from urlString: String) -> AnyPublisher<ItemDetails, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        return agent.execute(request)
    }
    
    private static func requestItems(limit: Int = 200) -> AnyPublisher<APIResponse, Error>? {
        var url = baseURL.appendingPathComponent("PokemonAPI.ItemType.items.rawValue")
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let query = URLQueryItem(name: "limit", value: "\(limit)")
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return nil }
        url = finalURL
        
        return agent.execute(URLRequest(url: url))
    }
     */
}
