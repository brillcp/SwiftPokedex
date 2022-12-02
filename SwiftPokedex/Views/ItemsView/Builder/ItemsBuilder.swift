//
//  ItemsBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsBuilder {

    static func build(withItemData itemData: ItemData?) -> ItemsController {
        let title = itemData?.title
        let items = itemData?.items ?? []
        let viewModel = ItemsView.ViewModel(title: title, items: items)
        return ItemsController(viewModel: viewModel)
    }
}
