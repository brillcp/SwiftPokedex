import Foundation
import Combine

struct PokemonAPI {
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    enum PokemonType: String, CaseIterable {
        case ground, flying, fire, water
    }
    
    static func requestPokemon(type: PokemonType) throws -> PokemonResponse {
        let url = baseURL.appendingPathComponent("type/" + type.rawValue)
        let request = URLRequest(url: url)
        let response: PokemonResponse = try NetworkAgent.makeCall(to: request)
        return response
    }
}
