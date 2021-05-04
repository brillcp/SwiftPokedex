//
//  UITabBarItem.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UITabBarItem {
    static func pokedex(title: String?) -> UITabBarItem {
        UITabBarItem(title: title, image: .pokedex, tag: 0)
    }
    
    static func items(title: String?) -> UITabBarItem {
        UITabBarItem(title: title, image: .items, tag: 1)
    }
}
