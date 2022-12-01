//
//  ListRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ListRoutable {
    func routeToItemList(with data: ItemData)
}

// MARK: -
final class ListRouter: ListRoutable {
    
    // MARK: Public properties
    weak var navigationController: UINavigationController?
    
    // MARK: - Public functions
    func routeToItemList(with data: ItemData) {
//        let view = ItemsViewBuilder.build(with: data)
//        navigationController?.pushViewController(view, animated: true)
    }
}
