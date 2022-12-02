//
//  Endpoints.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-30.
//

import Networking

enum Endpoint {
    case pokemon
    case details(String)
    case items
    case itemDetails(String)
}

// MARK: -
extension Endpoint: EndpointType {

    var path: String {
        switch self {
        case .pokemon: return "pokemon"
        case .details(let id): return "pokemon/\(id)"
        case .items: return "item"
        case .itemDetails(let id): return "item/\(id)"
        }
    }
}