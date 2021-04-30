import UIKit

struct PokemonAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    enum PokemonType: String, CaseIterable {
        case electric, ground, flying, fire, water, grass
    }
    
    static func requestPokemon(type: PokemonType, _ completion: @escaping (Result<PokemonResponse, Error>) -> Swift.Void) {
        let url = baseURL.appendingPathComponent("type/" + type.rawValue)
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func requestPokemonDetails(from urlString: String, _ completion: @escaping (Result<PokemonDetails, Error>) -> Swift.Void) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func loadPokemonSprite(from urlString: String, _ completion: @escaping (Result<UIImage?, Error>) -> Swift.Void) {
        requestPokemonDetails(from: urlString) { result in
            switch result {
            case let .success(details):
                UIImage.load(from: details.sprites.imageURL) { image in
                    completion(.success(image))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
