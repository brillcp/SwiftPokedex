//
//  ItemModels.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
//

import Foundation

struct ItemDetails: Decodable {
    let name: String
    let sprites: ItemSprite
    let category: APIItem
    let effect: [Effect]
    
    private enum CodingKeys: String, CodingKey {
        case name, sprites, category
        case effect = "effect_entries"
    }
}

struct ItemSprite: Decodable {
    let `default`: String
}

struct Effect: Decodable {
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case description = "effect"
    }
}
