//
//  APIModels.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
//

import Foundation

struct APIResponse: Decodable {
    let next: String
    let results: [APIItem]
}

struct APIItem: Decodable {
    let name: String
    let url: String
}
