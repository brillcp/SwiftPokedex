//
//  ItemsBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// A builder object used for building the `ItemsView` with all its' dependencies
final class ItemsBuilder {
    /// Build a `ItemsController`
    /// - parameter itemData: The given item data to display
    /// - returns: A new configured `ItemsController`
    static func build(withItemData itemData: ItemData?) -> ItemsController {
        let title = itemData?.title
        let items = itemData?.items ?? []
        let viewModel = ItemsView.ViewModel(title: title, items: items)
        return ItemsController(viewModel: viewModel)
    }
}
