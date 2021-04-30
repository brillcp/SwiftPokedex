import Foundation

struct PokemonResponse: Decodable {
    let pokemon: [TypePokemon]
}

struct TypePokemon: Decodable {
    let pokemon: Pokemon
}

struct Pokemon: Decodable {
    let name: String
}
