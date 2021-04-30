//
//  UIColor.swift
//  CombineSample
//
//  Created by Viktor Gidlöf on 2021-04-30.
//

import UIKit

extension UIColor {

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        let hexStart = hex[hex.startIndex] == "#"
        let current = String.Index(utf16Offset: hexStart ? 1 : 0, in: hex)
        scanner.currentIndex = current
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat((rgb & 0xFF)) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
