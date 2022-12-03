//
//  ItemListBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

/// A builder object used for building the `ItemListView` with all its' dependencies
final class ItemListBuilder {

    /// Build a `ItemListController` wrapped in a `NavigationController`
    /// - returns: A new navigation controller with the item list view controller as root controller
    static func build() -> NavigationController {
        let router = ItemListRouter()
        let interactor = ItemListInteractor(router: router, service: .default)
        let viewController = ItemListController(viewModel: .init(), interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
