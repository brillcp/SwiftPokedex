//
//  UITableView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UITableView {
    /// Register a cell in the table view
    /// - parameter cell: The cell to register
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    /// Dequeue a cell in the table view
    /// - parameter type: The type cell to dequeue
    /// - returns: The dequeued cell
    func dequeueCell<Cell: UITableViewCell>(for type: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier) as! Cell
    }
}
