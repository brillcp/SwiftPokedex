//
//  ItemsViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemsView {
    /// A data structure for the items view model
    final class ViewModel {
        @Published var title: String? = nil
        @Published var items: [ItemDetails] = []

        init(title: String? = nil, items: [ItemDetails] = []) {
            self.title = title
            self.items = items
        }
    }
}

// MARK: -
extension ItemsView.ViewModel {
    var cleanTitle: String? { title?.cleaned }
}
