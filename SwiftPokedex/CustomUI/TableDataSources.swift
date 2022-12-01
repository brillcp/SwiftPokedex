//
//  TableDataSources.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

extension UITableView {

    typealias DetailViewDataSource = UITableViewDiffableDataSource<DetailView.Section, DetailView.Item>

    /// A diffable data source object registered with a `DetailCell` cell.
    /// Used in the table view in the `DetailView`.
    /// - parameter viewModel: The view model of the view
    /// - returns: A diffable data source for the table view
    func detailViewDataSource(viewModel: DetailView.ViewModel) -> DetailViewDataSource {
        contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
        registerCell(DetailCell.self)
        registerCell(StatCell.self)

        let dataSource = DetailViewDataSource(tableView: self) { tableView, indexPath, item in
            switch DetailView.Section(rawValue: indexPath.section) {
            case .stats:
                let cell = tableView.dequeueCell(for: StatCell.self)
                cell.configure(withStat: item as? StatItem)
                self.rowHeight = 60.0
                return cell
            case .details:
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
        snapshot.appendSections([.details])
        snapshot.appendItems([viewModel.abilities])
        snapshot.appendItems([viewModel.moves])
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }
}

// MARK: -
extension UITableView {

    typealias ListViewDataSource = UITableViewDiffableDataSource<ListView.Section, ListView.Item>

    /// A diffable data source object registered with a `RegularCell` cell.
    /// Used in the table view in the `ListView`.
    /// - parameter viewModel: The view model of the view
    /// - returns: A diffable data source for the table view
    func listViewDataSource(viewModel: ListView.ViewModel, delegate del: UITableViewDelegate) -> ListViewDataSource {
        registerCell(RegularCell.self)
        rowHeight = 60.0
        delegate = del

        let dataSource = ListViewDataSource(tableView: self) { tableView, indexPath, item in
            let cell = tableView.dequeueCell(for: RegularCell.self)
            cell.configure(with: item)
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<ListView.Section, ListView.Item>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(viewModel.categories)
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }
}
