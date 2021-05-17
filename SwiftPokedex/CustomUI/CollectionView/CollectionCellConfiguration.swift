//
//  CollectionCellConfiguration.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol CollectionCellConfigurator {
    static var cellType: UICollectionViewCell.Type? { get }
    static var reuseId: String { get }
    func configureCell(_ cell: UICollectionViewCell)
}

final class CollectionCellConfiguration<Cell: ConfigurableCell, Data>: CollectionCellConfigurator where Data == Cell.DataType {
    
    static var cellType: UICollectionViewCell.Type? { Cell.self as? UICollectionViewCell.Type }
    static var reuseId: String { String(describing: Cell.self) }
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func configureCell(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else { return }
        cell.configure(with: data)
    }
}
