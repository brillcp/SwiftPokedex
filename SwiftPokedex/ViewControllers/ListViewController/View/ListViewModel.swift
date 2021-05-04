//
//  ListViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ListViewController {
    
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
                    
                    let cells: [RegularCellConfig] = organizedItems.sorted(by: { $0.key < $1.key }).map { .itemCell(title: $0.key, items: $0.value) }
                    let section = UITableView.Section(items: cells)
                    
                    let tableData = UITableView.DataSource(sections: [section])
                    DispatchQueue.main.async { completion(.success(tableData)) }
                    
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
