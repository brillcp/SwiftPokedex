//
//  ItemListRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ItemListRouterProtocol {
    func routeToDetailView(data: ItemData)
}

final class ItemListRouter: ItemListRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToDetailView(data: ItemData) {
        let view = ItemsViewBuilder.build(with: data)
        navigationController?.pushViewController(view, animated: true)
    }
}
