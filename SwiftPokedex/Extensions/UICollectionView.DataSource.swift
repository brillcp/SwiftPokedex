//
//  UICollectionView.DataSource.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
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
}

// MARK: -
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

// MARK: -
extension UICollectionView.DataSource {
    
    private typealias UniqueCellTypes = [String: CellType]
    
    typealias CellType = UICollectionViewCell.Type
    
    var cellTypes: [CellType] {
        let allCellTypes = sections.flatMap { $0.items.compactMap { type(of: $0).cellType }}
        
        let uniqueTypes = allCellTypes.reduce(UniqueCellTypes()) {
            var cellTypes = $0
            let key = String(describing: $1)
            cellTypes[key] = $1
            return cellTypes
        }
        return Array(uniqueTypes.values)
    }
}

// MARK: -
extension UICollectionView.DataSource {
    
    static func pokemonDataSource(from pokemon: [PokemonDetails]) -> UICollectionView.DataSource {
        let cells: [CollectionCell] = pokemon
            .sorted(by: { $0.id < $1.id })
            .map { .pokemonCell(from: $0) }
        
        let section = UICollectionView.Section(items: cells)
        let collectionData = UICollectionView.DataSource(sections: [section])
        return collectionData
    }
}
