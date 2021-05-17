//
//  RegularCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

struct ItemData {
    var title: String? = nil
    var items: [ItemDetails] = []
}

// MARK: -
final class RegularCell: UITableViewCell, ConfigurableCell {

    // MARK: Public properties
    var data: ItemData?
    
    // MARK: - Public functions
    func configure(with data: ItemData) {
        self.data = data
        
        accessoryType = .disclosureIndicator
        textLabel?.text = data.title?.cleaned
        textLabel?.textColor = .white
        textLabel?.font = .pixel14
        backgroundColor = .clear
    }
}
