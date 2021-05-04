//
//  Data.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation

extension Data {
    var prettyJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
