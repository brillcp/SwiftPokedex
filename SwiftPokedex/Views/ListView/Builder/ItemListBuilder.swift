//
//  ListBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation


final class ListBuilder {
    
    static func build() -> NavigationController {
        let router = ListRouter()
        let interactor = ListInteractor(router: router, service: .default)
        let viewController = ListController(interactor: interactor, viewModel: .init())
        let navigationController = NavigationController(rootViewController: viewController)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
