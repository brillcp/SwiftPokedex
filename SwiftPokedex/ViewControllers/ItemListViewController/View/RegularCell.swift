//
//  RegularCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

struct ItemData {
    let title: String
    let items: [ItemDetails]
}

final class RegularCell: UITableViewCell, ConfigurableCell {
    var data: ItemData?
    
    func configure(with data: ItemData) {
        self.data = data
        
        accessoryType = .disclosureIndicator
        textLabel?.text = data.title.cleaned
        textLabel?.textColor = .white
        textLabel?.font = .pixel14
        backgroundColor = .clear
    }
}
