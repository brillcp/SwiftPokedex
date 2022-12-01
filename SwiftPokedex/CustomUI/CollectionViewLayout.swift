//
//  UICollectionViewLayout.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-03-05.
//

import UIKit

private typealias CompositionalLayout = UICollectionViewCompositionalLayout
private typealias EdgeInsets = NSDirectionalEdgeInsets
private typealias Section = NSCollectionLayoutSection
private typealias Group = NSCollectionLayoutGroup
private typealias Size = NSCollectionLayoutSize
private typealias Item = NSCollectionLayoutItem

typealias Layout = UICollectionViewLayout
// MARK: -
extension Layout {

    static var pokedexLayout: Layout {
        let itemSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = Item(layoutSize: itemSize)
        let groupSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160.0))
        let group = Group.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let padding: CGFloat = 16.0
        let spacing = CGFloat(padding)
        group.interItemSpacing = .fixed(spacing)
        let section = Section(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = EdgeInsets(top: 16.0, leading: 16.0, bottom: 30.0, trailing: 16.0)
        return CompositionalLayout(section: section)
    }
}
