//
//  UILabel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-10.
//

import UIKit

extension UILabel {
    static var accessoryView: UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .pixel17
        label.text = ">"
        label.sizeToFit()
        return label
    }
}
