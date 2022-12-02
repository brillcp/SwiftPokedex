//
//  UICollectionView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UICollectionView {

    static let footer = UICollectionView.elementKindSectionFooter

    func cell<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell? {
        cellForItem(at: indexPath) as? Cell
    }

    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }

    func registerReusableFooterView<View: UICollectionReusableView>(_ view: View.Type) {
        register(view.self, forSupplementaryViewOfKind: UICollectionView.footer, withReuseIdentifier: view.identifier)
    }

    func dequeueFooterView<View: UICollectionReusableView>(_ view: View.Type, at indexPath: IndexPath) -> UICollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.footer, withReuseIdentifier: view.identifier, for: indexPath)
    }
}
