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
    
    enum ItemType: String {
        case pokemons = "pokemon"
        case items = "item"
    }
    
    // MARK: - Public functions
    static func allItems(_ completion: @escaping (Result<[ItemDetails], Error>) -> Swift.Void) {
        request(.items, limit: 250)?.flatMap { response in
            Publishers.Sequence(sequence: response.results.compactMap { itemDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sinkToResult { result in
            completion(result)
        }.store(in: &cancellables)
    }

    static func allPokemon(_ completion: @escaping (Result<[PokemonDetails], Error>) -> Swift.Void) {
        request(.pokemons)?.flatMap { response in
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
    
    private static func request(_ type: ItemType, limit: Int = 151) -> AnyPublisher<APIResponse, Error>? {
        var url = baseURL.appendingPathComponent(type.rawValue)
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let query = URLQueryItem(name: "limit", value: "\(limit)")
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return nil }
        url = finalURL
        
        return agent.execute(URLRequest(url: url))
    }
}
