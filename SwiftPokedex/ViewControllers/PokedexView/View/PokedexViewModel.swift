//
//  PokedexViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension PokedexView {

    final class ViewModel {
        @Published var pokemon = [PokemonDetails]()
        @Published var state: State = .idle

        enum State {
            case idle
            case loading
        }
    }
}

// MARK: -
extension PokedexView.ViewModel {
    var title: String { "Pokedex" }
}
