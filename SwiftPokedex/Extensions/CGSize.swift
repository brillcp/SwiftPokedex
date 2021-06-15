//
//  CGSize.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-15.
//

import UIKit

extension CGSize {
    static func cellSize(from collectionView: UICollectionView) -> CGSize {
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
}
