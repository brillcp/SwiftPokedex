//
//  ItemListViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemListView {
    /// A data structure for the item list view model
    final class ViewModel {
        @Published var state: State = .idle
        
        enum State {
            case idle
            case loading
            case loaded([ItemData])
        }
    }
}

// MARK: -
extension ItemListView.ViewModel {
    var title: String { "Items" }
}
