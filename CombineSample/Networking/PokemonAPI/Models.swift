import Foundation

struct PokemonResponse: Decodable {
    let results: [Item]
}

struct Item: Decodable {
    let name: String
    let url: String
}

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let baseExperience: Int
    let forms: [Item]
    let sprite: Sprite
    let abilities: [Ability]
    let moves: [Move]
    let types: [Type]
    let stats: [Stat]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, weight, height, forms, abilities, moves, types, stats
        case baseExperience = "base_experience"
        case sprite = "sprites"
    }
}

struct Sprite: Decodable {
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Decodable {
    let ability: Item
}

struct Move: Decodable {
    let move: Item
}

struct Type: Decodable {
    let type: Item
}

struct Stat: Decodable {
    let baseStat: Int
    let stat: Item
    
    private enum CodingKeys: String, CodingKey {
        case stat
        case baseStat = "base_stat"
    }
}
