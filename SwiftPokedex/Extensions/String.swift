//
//  String.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

extension String {
    var cleaned: String { replacingOccurrences(of: "-", with: " ").capitalized }
}
