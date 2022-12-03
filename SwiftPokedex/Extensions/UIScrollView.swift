//
//  UIScrollView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import UIKit

extension UIScrollView {
    /// A boolean value that is true if the scroll view has scrolled to the bottom of the view
    var hasScrolledToBottom: Bool {
        contentSize.height - contentOffset.y < frame.size.height * 1.6
    }
}
