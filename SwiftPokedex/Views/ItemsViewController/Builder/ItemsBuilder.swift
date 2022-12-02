//
//  ItemsBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsBuilder {
    
    static func build(with itemData: ItemData) -> ItemsController {
        ItemsController(viewModel: .init(itemData: itemData))
    }
}
