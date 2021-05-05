//
//  UIScrollView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import UIKit

extension UIScrollView {
    var hasScrolledToBottom: Bool {
        let height = frame.size.height
        let contentYoffset = contentOffset.y
        let distanceFromBottom = contentSize.height - contentYoffset
        return distanceFromBottom < (height * 1.6)
    }
}
