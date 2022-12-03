//
//  ItemListRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// A protocol for the item list router implementation
protocol ItemListRoutable: Routable {
    /// Route to the item list
    /// - parameter data: The data item to show in the list
    func routeToItemList(with data: ItemData)
}

// MARK: -
/// The `ItemListRouter` implementation
final class ItemListRouter: ItemListRoutable {

    // MARK: Public properties
    weak var navigationController: UINavigationController?

    // MARK: - Public functions
    func routeToItemList(with data: ItemData) {
        let itemsView = ItemsBuilder.build(withItemData: data)
        navigationController?.pushViewController(itemsView, animated: true)
    }
}
