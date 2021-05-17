//
//  UITableView.DataSource.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
//

import UIKit

extension UITableView {
    struct Section {
        var title: String? = nil
        var items: [TableCellConfigurator] = []
    }

    struct DataSource {
        var sections = [Section]()
    }
}

// MARK: -
extension UITableView.DataSource {
    
    var hasData: Bool { !sections.isEmpty }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].items.count
    }
    
    func title(in section: Int) -> String? {
        sections[section].title
    }
    
    func item(at indexPath: IndexPath) -> TableCellConfigurator {
        sections[indexPath.section].items[indexPath.row]
    }
}

// MARK: -
extension UITableView.DataSource {
    
    private typealias UniqueCellTypes = [String: CellType]
    
    typealias CellType = UITableViewCell.Type
    
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
extension UITableView.DataSource {
    
    static func detailedItemsDataSource(from result: [ItemDetails]) -> UITableView.DataSource {
        let cells: [ItemCellConfig] = result.map { .itemCell(data: $0) }
        let section = UITableView.Section(items: cells)
        return UITableView.DataSource(sections: [section])
    }

    static func itemsDataSource(from items: [ItemDetails]) -> UITableView.DataSource {
        let organizedItems = items.reduce([String: [ItemDetails]]()) { itemsDict, item -> [String: [ItemDetails]] in
            var itemsDict = itemsDict
            let items = items
                .filter { $0.category.name == item.category.name }
                .sorted(by: { $0.name < $1.name })
            
            itemsDict[item.category.name] = items
            return itemsDict
        }
        
        let cells: [RegularCellConfig] = organizedItems
            .sorted(by: { $0.key < $1.key })
            .map { .regularCell(title: $0.key, items: $0.value) }
        
        let section = UITableView.Section(items: cells)
        let dataSource = UITableView.DataSource(sections: [section])
        
        return dataSource
    }
}
