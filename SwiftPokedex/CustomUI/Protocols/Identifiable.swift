//
//  Identifiable.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-23.
//

import Foundation

/// A protocol that makes its' subscribers identifiable
protocol Identifiable {
    /// A static string that identifies the object
    static var identifier: String { get }
}

// MARK: -
extension Identifiable {
    static var identifier: String { String(describing: self) }
}
