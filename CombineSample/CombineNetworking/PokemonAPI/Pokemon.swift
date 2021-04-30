import Foundation

struct PokemonResponse: Decodable {
    let pokemon: [TypePokemon]
}

struct TypePokemon: Decodable {
    let pokemon: Pokemon
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonDetails: Decodable {
    let name: String
    let baseExperience: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case baseExperience = "base_experience"
    }
}
