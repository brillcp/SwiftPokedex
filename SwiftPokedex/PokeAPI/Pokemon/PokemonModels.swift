//
//  Models.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let baseExperience: Int
    let sprite: Sprite
    let abilities: [Ability]
    let moves: [Move]
    let types: [Type]
    let stats: [Stat]

    private enum CodingKeys: String, CodingKey {
        case id, name, weight, height, abilities, moves, types, stats
        case baseExperience = "base_experience"
        case sprite = "sprites"
    }
}

// MARK: -
extension PokemonDetails: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: -
extension PokemonDetails: Equatable {

    static func == (lhs: PokemonDetails, rhs: PokemonDetails) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: -
struct Sprite: Decodable {
    let url: String

    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

// MARK: -
struct Ability: Decodable {
    let ability: APIItem
}

// MARK: -
struct Move: Decodable {
    let move: APIItem
}

// MARK: -
struct Type: Decodable {
    let type: APIItem
}

// MARK: -
struct Stat: Decodable {
    let baseStat: Int
    let stat: APIItem

    private enum CodingKeys: String, CodingKey {
        case stat
        case baseStat = "base_stat"
    }
}
