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
        let interactor = ItemListInteractor(router: router)
        let viewController = ItemListViewController(interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        router.navigationController = navigationController
        
        return navigationController
    }
}
