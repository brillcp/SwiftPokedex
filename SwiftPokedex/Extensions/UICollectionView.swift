//
//  UICollectionView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UICollectionView {
    struct Section {
        var title: String? = nil
        let items: [CollectionCellConfigurator]
    }

    struct DataSource {
        var sections = [Section]()
    }

    func cell<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForItem(at: indexPath) as? Cell
    }
    
    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier(for: cell))
    }

    func dequeueCell<Cell: UICollectionViewCell>(for item: CollectionCellConfigurator, at indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath) as! Cell
    }

    private func reuseIdentifier<Cell: UICollectionViewCell>(for cell: Cell.Type) -> String {
        String(describing: cell)
    }
}

extension UICollectionView.DataSource {
    
    var hasData: Bool { !sections.isEmpty }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> CollectionCellConfigurator {
        sections[indexPath.section].items[indexPath.row]
    }
}
