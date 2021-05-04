//
//  ItemsViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

final class ItemsViewBuilder {
    
    static func build() -> NavigationController {
        let viewController = ItemsViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
