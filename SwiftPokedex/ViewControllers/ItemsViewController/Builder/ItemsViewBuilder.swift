//
//  ItemsViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsViewBuilder {
    
    static func build(with itemData: ItemData = .init()) -> ItemsViewController {
        let viewModel = ItemsViewController.ViewModel(title: itemData.title)
        return ItemsViewController(viewModel: viewModel, tableData: .detailedItemsDataSource(from: itemData.items))
    }
}
