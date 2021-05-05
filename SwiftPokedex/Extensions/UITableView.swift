//
//  UITableView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
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

    func cell<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForRow(at: indexPath) as? Cell
    }
    
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: reuseIdentifier(for: cell))
    }

    func dequeueCell<Cell: UITableViewCell>(for item: TableCellConfigurator) -> Cell {
        dequeueReusableCell(withIdentifier: type(of: item).reuseId) as! Cell
    }

    private func reuseIdentifier<Cell: UITableViewCell>(for cell: Cell.Type) -> String {
        String(describing: cell)
    }
}

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

extension UITableView.DataSource {
    
    static func itemsDataSource(from items: [ItemDetails]) -> UITableView.DataSource {
        let organizedItems = items.reduce([String: [ItemDetails]]()) { itemsDict, item -> [String: [ItemDetails]] in
            var itemsDict = itemsDict
            let items = items.filter { $0.category.name == item.category.name }
            let sorted = items.sorted(by: { $0.name < $1.name })
            itemsDict[item.category.name] = sorted
            return itemsDict
        }
        
        let cells: [RegularCellConfig] = organizedItems.sorted(by: { $0.key < $1.key }).map { .itemCell(title: $0.key, items: $0.value) }
        let section = UITableView.Section(items: cells)
        
        return UITableView.DataSource(sections: [section])
    }
}
