//
//  UICollectionView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UICollectionView {
    static let footer = UICollectionView.elementKindSectionFooter
    
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
        register(cell.self, forCellWithReuseIdentifier: String(describing: cell))
    }

    func registerReusableFooter<View: UICollectionReusableView>(view: View.Type) {
        register(view.self, forSupplementaryViewOfKind: UICollectionView.footer, withReuseIdentifier: String(describing: view))
    }
    
    func dequeueReusableView<View: UICollectionReusableView>(ofKind kind: String, at indexPath: IndexPath) -> View {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: View.self), for: indexPath) as! View
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(for item: CollectionCellConfigurator, at indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath) as! Cell
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

extension UICollectionView.DataSource {
    
    private typealias UniqueCellTypes = [String: UICollectionViewCell.Type]
    
    var cellTypes: [UICollectionViewCell.Type] {
        let cellTypes = sections.flatMap { $0.items.compactMap { type(of: $0).cellType }}
        
        let uniqueTypes = cellTypes.reduce(UniqueCellTypes()) {
            var cellTypes = $0
            cellTypes[String(describing: $1)] = $1
            return cellTypes
        }
        return Array(uniqueTypes.values)
    }
}

extension UICollectionView.DataSource {
    
    static func pokemonDataSource(from pokemon: [PokemonDetails]) -> UICollectionView.DataSource {
        let sorted = pokemon.sorted(by: { $0.id < $1.id })
        let items: [CollectionCell] = sorted.map { .pokemonCell(from: $0) }
        let section = UICollectionView.Section(items: items)
        let collectionData = UICollectionView.DataSource(sections: [section])
        return collectionData
    }
}
