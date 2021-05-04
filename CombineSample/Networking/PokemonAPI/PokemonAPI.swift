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
    static func allPokemon(_ completion: @escaping (Result<[PokemonDetails], Error>) -> Swift.Void) {
        requestPokemon()?.flatMap { response in
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
    private static func pokemonDetails(from urlString: String) -> AnyPublisher<PokemonDetails, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        return agent.execute(request)
    }
    
    private static func requestPokemon() -> AnyPublisher<PokemonResponse, Error>? {
        var url = baseURL.appendingPathComponent("pokemon")
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let query = URLQueryItem(name: "limit", value: "151")
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return nil }
        url = finalURL
        
        return agent.execute(URLRequest(url: url))
    }
}
