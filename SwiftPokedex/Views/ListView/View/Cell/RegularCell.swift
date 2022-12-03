//
//  RegularCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

// MARK: -
final class RegularCell: UITableViewCell {

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = UILabel.accessoryView
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public functions
    func configure(with data: ItemData) {
        textLabel?.text = data.title?.cleaned
        textLabel?.textColor = .white
        textLabel?.font = .pixel14
    }
}
