//
//  CollectionCellConfigurations.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import Foundation

typealias CollectionCell = CollectionCellConfiguration<PokedexCell, PokemonDetails>

extension CollectionCellConfiguration {
    
    static func pokemonCell(from pokemon: PokemonDetails) -> CollectionCell {
        CollectionCell(data: pokemon)
    }
}
