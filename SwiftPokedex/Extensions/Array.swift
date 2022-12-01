//
//  Array.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import Foundation

extension Array where Element == ItemDetails {

    var categories: [ItemData] {
        let organizedItems = reduce([String: [ItemDetails]]()) { itemsDict, item -> [String: [ItemDetails]] in
            var itemsDict = itemsDict
            let items = filter { $0.category.name == item.category.name }.sorted(by: { $0.name < $1.name })
            itemsDict[item.category.name] = items
            return itemsDict
        }
        let categories = organizedItems.sorted(by: { $0.key < $1.key }).map { ItemData(title: $0.key, items: $0.value) }
        return categories
    }
}
