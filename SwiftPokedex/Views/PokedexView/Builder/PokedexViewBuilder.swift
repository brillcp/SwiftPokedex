//
//  PokedexViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Networking

final class PokedexViewBuilder {

    static func build() -> NavigationController {
        let router = PokedexRouter()
        let interactor = PokedexInteractor(router: router, service: .default)
        let viewController = PokedexController(viewModel: .init(), interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
