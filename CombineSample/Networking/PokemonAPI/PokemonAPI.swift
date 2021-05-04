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
            Publishers.Sequence(sequence: response.results.map { pokemonDetails(from: $0.url) })
                .flatMap { $0 }
                .collect()
        }
        .eraseToAnyPublisher()
        .sink { completed in
            switch completed {
            case let .failure(error): completion(.failure(error))
            case .finished: break
            }
        } receiveValue: { result in
            completion(.success(result))
        }.store(in: &cancellables)
    }

    // MARK: - Private functions
    private static func pokemonDetails(from urlString: String) -> AnyPublisher<PokemonDetails, Error> {
        URLSession.shared.dataTaskPublisher(for: URLRequest(url: URL(string: urlString)!))
            .tryMap { $0.data }
            .decode(type: PokemonDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private static func requestPokemon() -> AnyPublisher<PokemonResponse, Error>? {
        var url = baseURL.appendingPathComponent("pokemon")
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let query = URLQueryItem(name: "limit", value: "151")
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return nil }
        url = finalURL
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap {$0.data }
            .decode(type: PokemonResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
