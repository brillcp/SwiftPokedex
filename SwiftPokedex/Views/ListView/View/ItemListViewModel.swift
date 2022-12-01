//
//  ItemListViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemListView {

    final class ViewModel {
        @Published var categories = [ItemData]()
    }
}

// MARK: -
extension ItemListView.ViewModel {
    var title: String { "Items" }
}
