//
//  ItemsViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemsViewController {
    
    struct ViewModel: ViewModelProtocol {
        var title: String { "Items" }
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
            PokemonAPI.allItems { result in
                switch result {
                case let .success(items):
                    let organizedItems = items.reduce([String: [ItemDetails]]()) { itemsDict, item -> [String: [ItemDetails]] in
                        var itemsDict = itemsDict
                        let items = items.filter { $0.category.name == item.category.name }
                        let sorted = items.sorted(by: { $0.name < $1.name })
                        itemsDict[item.category.name] = sorted
                        return itemsDict
                    }
                    
                    let sections = organizedItems.map { key, value -> UITableView.Section in
                        let cells = value.map { TableCellConfiguration<ItemCell, ItemDetails>(data: $0, rowHeight: UITableView.automaticDimension) }
                        return UITableView.Section(title: key.cleaned, items: cells)
                    }.sorted(by: { $0.title ?? "" < $1.title ?? "" })
                    
                    let tableData = UITableView.DataSource(sections: sections)
                    DispatchQueue.main.async { completion(.success(tableData)) }
                    
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
              
                }
            }
        }
    }
}
