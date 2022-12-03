//
//  DetailBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// A builder object used for building the `DetailView` with all its' dependencies
final class DetailBuilder {
    /// Build a `DetailController` wrapped in a `NavigationController`
    /// - parameters:
    ///     - pokemon: The given pokemon
    ///     - color: The dominant background color of the pokemon sprite
    /// - returns: A new navigation controller with the detail view controller as root controller
    static func build(from pokemon: PokemonDetails, withColor color: UIColor) -> NavigationController {
        let viewModel = DetailView.ViewModel(pokemon: pokemon, color: color)
        let detailView = DetailController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: detailView)
        navigationController.setNavbarApp(color: color)
        return navigationController
    }
}
