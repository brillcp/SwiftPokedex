//
//  TableViewable.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

/// A protocol used in views to make them table viewable
protocol TableViewable where Self: UIView {
    /// The associated section type
    associatedtype Section: Hashable
    /// The associated item type
    associatedtype Item: Hashable

    /// The data source for the collection view
    var dataSource: UITableViewDiffableDataSource<Section, Item>! { get }
    /// The table view in the view
    var tableView: UITableView { get }
}
