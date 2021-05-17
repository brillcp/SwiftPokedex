//
//  TableCellConfiguration.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    
    var data: DataType? { get }
    func configure(with data: DataType)
}

protocol TableCellConfigurator {
    static var cellType: UITableViewCell.Type? { get }
    static var reuseId: String { get }
    var rowHeight: CGFloat { get }
    func configureCell(_ cell: UITableViewCell)
}

final class TableCellConfiguration<Cell: ConfigurableCell, Data>: TableCellConfigurator where Data == Cell.DataType {
    
    static var cellType: UITableViewCell.Type? { Cell.self as? UITableViewCell.Type }
    static var reuseId: String { String(describing: Cell.self) }
    
    var rowHeight: CGFloat
    let data: Data
    
    init(data: Data, rowHeight: CGFloat = 60.0) {
        self.data = data
        self.rowHeight = rowHeight
    }
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? Cell else { return }
        cell.configure(with: data)
    }
}
