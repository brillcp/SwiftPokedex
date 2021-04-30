import Foundation
import Combine

struct PokemonAPI {
    private static let agent = NetworkAgent()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    private static var cancellable: AnyCancellable?

    enum PokemonType: String, CaseIterable {
        case electric, ground, flying, fire, water
    }
    
    static func requestPokemon(type: PokemonType, _ completion: @escaping (Result<PokemonResponse, Error>) -> Swift.Void) {
        let url = baseURL.appendingPathComponent("type/" + type.rawValue)
        let request = URLRequest(url: url)
        
        let publisher: AnyPublisher<PokemonResponse, Error> = agent.execute(request)

        cancellable = publisher.sink { completed in
            switch completed {
            case .failure(let error): completion(.failure(error))
            case .finished: break
            }
        } receiveValue: { response in
            completion(.success(response))
        }
    }
}
