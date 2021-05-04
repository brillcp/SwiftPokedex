//
//  ItemListInteractor.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ItemListInteractorProtocol {
    func selectItem(at indexPath: IndexPath, in tableView: UITableView)
}

final class ItemListInteractor: ItemListInteractorProtocol {
    
    private let router: ItemListRouterProtocol
    
    init(router: ItemListRouterProtocol) {
        self.router = router
    }
    
    func selectItem(at indexPath: IndexPath, in tableView: UITableView) {
        guard let cell = tableView.cell(at: indexPath) as? RegularCell,
              let itemData = cell.data
        else { return }

        router.routeToDetailView(data: itemData)
    }
}
