import Foundation
import Combine

struct PokemonAPI {
    private static let baseURL = URL(string: "https://viktorgidlof.com")!
    
    static func searchPokemons() throws -> PokemonResponse {
        let request = URLRequest(url: baseURL)
        let response: PokemonResponse = try NetworkAgent.makeCall(to: request)
        return response
    }
}
