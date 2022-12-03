//
//  CGRect.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-03.
//

import Foundation

extension CGRect {
    /// Inset the current frame with a edge inset
    /// - returns: The new insetted rect
    func imageInset() -> CGRect {
        inset(by: .init(top: 0, left: 10, bottom: 15, right: 10))
    }
}
