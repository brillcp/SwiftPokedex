//
//  ItemsViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemsView {

    struct ViewModel {
        let itemData: ItemData
    }
}

// MARK: -
extension ItemsView.ViewModel {
    var cleanTitle: String? { itemData.title?.cleaned }
}
