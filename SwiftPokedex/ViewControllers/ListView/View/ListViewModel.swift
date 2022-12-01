//
//  ListViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ListView {

    final class ViewModel {
        @Published var items = [ItemDetails]()
    }
}

// MARK: -
extension ListView.ViewModel {
    var title: String { "Items" }
}
