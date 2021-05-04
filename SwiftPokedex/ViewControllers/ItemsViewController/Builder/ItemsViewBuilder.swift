//
//  ItemsViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsViewBuilder {
    
    static func build(with itemData: ItemData) -> ItemsViewController {
        let viewModel = ItemsViewController.ViewModel(item: itemData)
        
        let cells = itemData.items.map { TableCellConfiguration<ItemCell, ItemDetails>(data: $0, rowHeight: UITableView.automaticDimension) }
        
        let section = UITableView.Section(items: cells)
        
        let tableData = UITableView.DataSource(sections: [section])
        
        let viewController = ItemsViewController(viewModel: viewModel, tableData: tableData)
        
        return viewController
    }
}
