//
//  ItemListBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

final class ItemListBuilder {
    
    static func build() -> NavigationController {
        let viewController = ItemListViewController(style: .grouped)
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
