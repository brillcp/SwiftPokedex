//
//  TableDataSources.swift
//  EBerry
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

typealias DiffableTableDataSource = UITableViewDiffableDataSource

extension UITableView {

    typealias DetailViewDataSource = DiffableTableDataSource<DetailView.Section, DetailView.Item>

    /// A diffable data source object registered with a `DetailCell` cell.
    /// Used in the table view in the `DetailView`.
    /// - parameter viewModel: The view model of the view
    /// - returns: A diffable data source for the table view
    func detailViewDataSource(viewModel: DetailView.ViewModel) -> DetailViewDataSource {
        registerCell(DetailCell.self)
        registerCell(StatCell.self)
        contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)

        let dataSource = DetailViewDataSource(tableView: self) { tableView, indexPath, item in
            switch DetailView.Section(rawValue: indexPath.section) {
            case .stats:
                let cell = tableView.dequeueCell(for: StatCell.self)
                cell.configure(withStat: item as? StatItem)
                self.rowHeight = 60.0
                return cell
            case .abilities, .moves, .types:
                let cell = tableView.dequeueCell(for: DetailCell.self)
                cell.configure(withItem: item as? DetailItem)
                self.rowHeight = UITableView.automaticDimension
                return cell
            case .none:
                fatalError("Cell can't be dequeued. Shouldn't happen")
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<DetailView.Section, DetailView.Item>()
        snapshot.appendSections([.stats])
        snapshot.appendItems(viewModel.stats)
        snapshot.appendSections([.types])
        snapshot.appendItems([viewModel.types])
        snapshot.appendSections([.abilities])
        snapshot.appendItems([viewModel.abilities])
        snapshot.appendSections([.moves])
        snapshot.appendItems([viewModel.moves])
        dataSource.apply(snapshot)
        return dataSource
    }
}
