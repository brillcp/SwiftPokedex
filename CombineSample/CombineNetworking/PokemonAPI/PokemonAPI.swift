import Foundation

struct PokemonAPI {
    private static let agent = NetworkAgent<PokemonResponse>()
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    enum PokemonType: String, CaseIterable {
        case electric, ground, flying, fire, water
    }
    
    static func requestPokemon(type: PokemonType, _ completion: @escaping (Result<PokemonResponse, Error>) -> Swift.Void) {
        let url = baseURL.appendingPathComponent("type/" + type.rawValue)
        let request = URLRequest(url: url)
        agent.execute(request, completion)
    }
}
