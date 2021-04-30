import Foundation

struct PokemonResponse: Decodable {
    let results: [Pokemon]
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
    let weight: Int
    let height: Int
    let baseExperience: Int
    let forms: [Pokemon]
    let sprites: Sprite
    
    private enum CodingKeys: String, CodingKey {
        case name, weight, height, forms, sprites
        case baseExperience = "base_experience"
    }
}

struct Sprite: Decodable {
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
