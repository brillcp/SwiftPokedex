//
//  UINib+Extensions.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import UIKit

extension UINib {
    /// Initialize a new `UINib` from a `UIView`
    /// - parameter view: The view type to instantiate the nib from
    convenience init(view: UIView.Type) {
        self.init(nibName: view.identifier, bundle: nil)
    }
}
