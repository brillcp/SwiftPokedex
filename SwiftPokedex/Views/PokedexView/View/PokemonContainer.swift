//
//  PokemonContainer.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-02.
//

import UIKit

/// A container object used when selecting and transitioning to a pokemon detail view
struct PokemonContainer {
    let pokemon: PokemonDetails
    let image: UIImage
    let frame: CGRect
    let color: UIColor
}
