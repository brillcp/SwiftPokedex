//
//  PokemonAPI.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

struct PokemonAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private static var cancellables = Set<AnyCancellable>()
    
    private static var pokemonResponse: APIResponse?
    private static var itemResponse: APIResponse?
    
    enum ItemType: String {
        case pokemons = "pokemon"
        case items = "item"
    }
    
    // MARK: - Public functions
    static func allItems(_ completion: @escaping (Result<[ItemDetails], Error>) -> Swift.Void) {
        requestItems(limit: 450)?.flatMap { response in
            Publishers.Sequence(sequence: response.results.compactMap { itemDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sinkToResult { result in
            completion(result)
        }.store(in: &cancellables)
    }

    static func requestPokemon(_ completion: @escaping (Result<[PokemonDetails], Error>) -> Swift.Void) {
        requestPokemon(at: pokemonResponse?.next)?.flatMap { response in
            Publishers.Sequence(sequence: response.results.compactMap { pokemonDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sinkToResult { result in
            completion(result)
        }.store(in: &cancellables)
    }

    // MARK: - Private functions
    private static func itemDetails(from urlString: String) -> AnyPublisher<ItemDetails, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        return agent.execute(request)
    }

    private static func pokemonDetails(from urlString: String) -> AnyPublisher<PokemonDetails, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        return agent.execute(request)
    }
    
    private static func requestItems(limit: Int = 200) -> AnyPublisher<APIResponse, Error>? {
        var url = baseURL.appendingPathComponent(PokemonAPI.ItemType.items.rawValue)
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let query = URLQueryItem(name: "limit", value: "\(limit)")
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return nil }
        url = finalURL
        
        return agent.execute(URLRequest(url: url))
    }
    
    private static func requestPokemon(at urlString: String?) -> AnyPublisher<APIResponse, Error>? {
        let finalURL: URL
        
        if let urlString = urlString, let url = URL(string: urlString) {
            finalURL = url
        } else {
            finalURL = baseURL.appendingPathComponent(PokemonAPI.ItemType.pokemons.rawValue)
        }
                
        return agent.execute(URLRequest(url: finalURL)).map { (response: APIResponse) -> APIResponse in
            self.pokemonResponse = response
            return response
        }.eraseToAnyPublisher()
    }
}
