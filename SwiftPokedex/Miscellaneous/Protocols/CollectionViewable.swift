//
//  CollectionViewable.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-03-07.
//

import UIKit

/// A protocol for `UIView` making them collection viewable
protocol CollectionViewable where Self: UIView {
    /// The associated section type
    associatedtype Section: Hashable
    /// The associated item type
    associatedtype Item: Hashable

    /// The data source for the collection view
    var dataSource: DiffableDataSource<Section, Item>! { get }
    /// The collecion view in the view
    var collectionView: UICollectionView { get }
}
