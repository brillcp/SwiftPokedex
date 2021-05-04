//
//  DetailViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension DetailViewController {

    struct ViewModel {
        let pokemon: PokemonDetails
        let color: UIColor

        var id: String { "#\(pokemon.id)" }
        var title: String { pokemon.name.capitalized }
        var isLight: Bool { color.isLight }
        var spriteURL: String { pokemon.sprite.url }
    }
}
