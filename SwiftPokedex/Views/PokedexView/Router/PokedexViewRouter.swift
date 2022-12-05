//
//  PokedexRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// A protocol for the pokedex router implementation
protocol PokedexRoutable: Routable {
    /// Route to the detail view with the given pokemon details
    /// - parameter container: A pokemon container object with all the selection information
    func routeToDetailView(withPokemonContainer container: PokemonContainer)
}

// MARK: -
/// The `PokedexRouter` implementation
final class PokedexRouter: PokedexRoutable {

    // MARK: Public properties
    weak var navigationController: UINavigationController?

    // MARK: - Public functions
    func routeToDetailView(withPokemonContainer container: PokemonContainer) {
        let detailView = DetailBuilder.build(fromContainer: container)
        navigationController?.present(detailView, animated: true)
    }
}
