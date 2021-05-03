import UIKit

struct PokemonAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    enum ItemType: String {
        case pokemons = "pokemon"
        case items = "item"
    }
    
    static func request(_ type: ItemType, _ completion: @escaping (Result<APIResponse, Error>) -> Swift.Void) {
        var url = baseURL.appendingPathComponent(type.rawValue)
        
        let query = URLQueryItem(name: "limit", value: "2000")
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        urlComponents.queryItems = [query]
        
        guard let finalURL = urlComponents.url else { return }
        url = finalURL
        
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func requestDetails<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Swift.Void) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        agent.execute(request, completion: completion)
    }
    
    static func loadItemSprite(from urlString: String, _ completion: @escaping (UIImage?) -> Swift.Void) {
        let completion: (Result<Item, Error>) -> Swift.Void = { result in
            switch result {
            case let .success(item):
                UIImage.load(from: item.sprites.default) { image in
                    completion(image)
                }
            case .failure: completion(nil)
            }
        }
        
        requestDetails(from: urlString, completion: completion)
    }

    static func loadSprite(from urlString: String, _ completion: @escaping ((image: UIImage?, index: Int)) -> Swift.Void) {
        let completion: (Result<PokemonDetails, Error>) -> Swift.Void = { result in
            switch result {
            case let .success(details):
                UIImage.load(from: details.sprite.url) { image in
                    completion((image, details.id))
                }
            case .failure: completion((nil, 0))
            }
        }
        
        requestDetails(from: urlString, completion: completion)
    }
}
