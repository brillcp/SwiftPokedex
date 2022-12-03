//
//  PokedexViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// A builder object used for building the `PokedexView` with all its' dependencies
final class PokedexViewBuilder {
    /// Build a `PokedexController` wrapped in a `NavigationController`
    /// - returns: A new navigation controller with the pokedex view controller as root controller
    static func build() -> NavigationController {
        let router = PokedexRouter()
        let interactor = PokedexInteractor(router: router, service: .default)
        let viewController = PokedexController(viewModel: .init(), interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.setNavbarApp(color: .pokedexRed)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
