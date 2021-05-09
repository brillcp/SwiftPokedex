//
//  ListViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ListViewController {
    
    final class ViewModel: ViewModelProtocol {
        var title: String { "Items" }
        var items = [ItemDetails]()
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
            PokemonAPI.allItems { result in
                switch result {
                case let .success(items):
                    self.items = items
                    
                    let tableData: UITableView.DataSource = .itemsDataSource(from: items)
                    DispatchQueue.main.async { completion(.success(tableData)) }
                    
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
