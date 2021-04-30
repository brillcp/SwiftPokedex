import Foundation

struct PokemonResponse: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let id: String
    let name: String
}
