//
//  ItemListBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

final class ItemListBuilder {

    static func build() -> NavigationController {
        let router = ItemListRouter()
        let interactor = ItemListInteractor(router: router, service: .default)
        let viewController = ItemListController(interactor: interactor, viewModel: .init())
        let navigationController = NavigationController(rootViewController: viewController)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
