//
//  ListRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ListRouterProtocol {
    func routeToItemList(with data: ItemData)
}

final class ListRouter: ListRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToItemList(with data: ItemData) {
        let view = ItemsViewBuilder.build(with: data)
        navigationController?.pushViewController(view, animated: true)
    }
}
