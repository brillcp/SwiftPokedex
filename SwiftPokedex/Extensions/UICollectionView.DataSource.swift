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
        let cells: [CollectionCell] = pokemon
            .sorted(by: { $0.id < $1.id })
            .map { .pokemonCell(from: $0) }
        
        let section = UICollectionView.Section(items: cells)
        let collectionData = UICollectionView.DataSource(sections: [section])
        return collectionData
    }
}
