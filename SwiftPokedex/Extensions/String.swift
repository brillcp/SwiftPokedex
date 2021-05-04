//
//  String.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension String {
    var cleaned: String { replacingOccurrences(of: "-", with: " ").capitalized }
    
    func lineHeight(_ height: CGFloat) -> NSAttributedString? {
        var string = self
        string = string.replacingOccurrences(of: "é", with: "e")
        
        let attributedString = NSMutableAttributedString(string: string)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        return attributedString
    }
}
