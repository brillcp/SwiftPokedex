//
//  UIScrollView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import UIKit

extension UIScrollView {
    var hasScrolledToBottom: Bool {
        let distanceFromBottom = contentSize.height - contentOffset.y
        return distanceFromBottom < frame.size.height * 1.6
    }
}
