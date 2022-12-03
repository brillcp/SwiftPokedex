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
    /// - parameter pokemon: A pokemon container object with all the selection information
    func routeToDetailView(pokemon container: PokemonContainer)
}

// MARK: -
/// The `PokedexRouter` implementation
final class PokedexRouter: PokedexRoutable {

    // MARK: Public properties
    weak var navigationController: UINavigationController?

    // MARK: - Public functions
    func routeToDetailView(pokemon container: PokemonContainer) {
        let detailView = DetailBuilder.build(fromContainer: container)
        let interaction = InteractionController(viewController: detailView, cell: container.cell, image: container.image)
        let transitionManager = Transition(interaction: interaction, cell: container.cell)
        detailView.transitionManager = transitionManager
        detailView.transitioningDelegate = transitionManager
        detailView.modalPresentationStyle = .custom
        navigationController?.present(detailView, animated: true)
    }
}
