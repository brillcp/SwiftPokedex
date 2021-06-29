//
//  UIScrollView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-05.
//

import UIKit

extension UIScrollView {
    var hasScrolledToBottom: Bool { contentSize.height - contentOffset.y < frame.size.height * 1.6 }
}
