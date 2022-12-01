//
//  UIView+Extensions.swift
//  EBerry
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

extension UIView {
    // MARK: Public functions
    /// Initialize a new `UIView` from a nib
    /// - returns: An instantiated view
    class func instanceFromNib() -> Self {
        guard let view = UINib(view: Self.self).instantiate(withOwner: nil)[0] as? Self else { fatalError(".viewFailed") }
        return view
    }
}

// MARK: -
extension UIView: Identifiable {}
