import UIKit

struct PokemonAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    enum PokemonType: String, CaseIterable {
        case electric, ground, flying, fire, water, grass, psychic, normal, poison, ghost, fairy, fighting
    }
    
    static func requestPokemons(_ completion: @escaping (Result<PokemonResponse, Error>) -> Swift.Void) {
        var url = baseURL.appendingPathComponent("pokemon")
        
        let query = URLQueryItem(name: "limit", value: "2000")
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return }
        url = finalURL
        
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func requestPokemonDetails(from urlString: String, _ completion: @escaping (Result<PokemonDetails, Error>) -> Swift.Void) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func loadPokemonSprite(from urlString: String, _ completion: @escaping (Result<(UIImage?, Int), Error>) -> Swift.Void) {
        requestPokemonDetails(from: urlString) { result in
            switch result {
            case let .success(details):
                UIImage.load(from: details.sprites.imageURL) { image in
                    completion(.success((image, details.id)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
