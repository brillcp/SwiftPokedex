//
//  DetailItem.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-02.
//

import Foundation

struct DetailItem {
    let id = UUID()
    let title: String
    let value: String
}

// MARK: -
extension DetailItem: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
