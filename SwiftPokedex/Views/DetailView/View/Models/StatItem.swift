//
//  StatItem.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-02.
//

import UIKit

struct StatItem {
    let id = UUID()
    let title: String
    let value: Int
    let color: UIColor
}

// MARK: -
extension StatItem: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
