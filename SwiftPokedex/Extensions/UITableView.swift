//
//  UITableView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UITableView {

    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func dequeueCell<Cell: UITableViewCell>(for type: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier) as! Cell
    }
}
