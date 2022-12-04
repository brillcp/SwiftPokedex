//
//  DetailViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension DetailView {
    /// A data structure for the detail view model
    struct ViewModel {
        let pokemon: PokemonDetails
        let color: UIColor
    }
}

// MARK: -
extension DetailView.ViewModel {
    var title: String { pokemon.name.capitalized }
    var id: String { "#\(pokemon.id)" }
    var isLight: Bool { color.isLight }

    var stats: [StatItem] {
        pokemon.stats.compactMap {
            switch $0.stat.name {
            case "hp": return StatItem(title: "HP", value: $0.baseStat, color: .pokedexRed)
            case "attack": return StatItem(title: "ATK", value: $0.baseStat, color: .orange)
            case "defense": return StatItem(title: "DEF", value: $0.baseStat, color: .blue)
            case "speed": return StatItem(title: "SPD", value: $0.baseStat, color: .green)
            default: return nil
            }
        }
    }

    var abilities: DetailItem {
        let abilities = pokemon.abilities.map { $0.ability.name.cleaned }.joined(separator: "\n\n")
        return DetailItem(title: "Abilities", value: abilities)
    }

    var moves: DetailItem {
        let limit = 16
        let tooMany = pokemon.moves.count > limit
        var values = tooMany ? Array(pokemon.moves[0 ..< limit]) : pokemon.moves
        if tooMany { values.append(Move(move: APIItem(name: ". . .", url: ""))) }
        let moves = values.map { $0.move.name.cleaned }.joined(separator: "\n\n")
        return DetailItem(title: "Moves", value: moves)
    }
}
