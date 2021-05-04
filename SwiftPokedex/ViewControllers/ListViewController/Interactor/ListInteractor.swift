//
//  ListInteractor.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ListInteractorProtocol {
    func selectItem(at indexPath: IndexPath, in tableView: UITableView)
}

final class ListInteractor: ListInteractorProtocol {
    
    private let router: ListRouterProtocol
    
    init(router: ListRouterProtocol) {
        self.router = router
    }
    
    func selectItem(at indexPath: IndexPath, in tableView: UITableView) {
        guard let cell = tableView.cell(at: indexPath) as? RegularCell,
              let itemData = cell.data
        else { return }

        router.routeToDetailView(data: itemData)
    }
}
