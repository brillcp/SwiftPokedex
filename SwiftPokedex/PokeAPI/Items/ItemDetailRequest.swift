//
//  ItemDetailRequest.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import Networking

/// An enum for requesting the item detail data
enum ItemDetailRequest: Requestable {
    case item(String)

    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }

    var endpoint: EndpointType {
        switch self {
        case .item(let id): return Endpoint.itemDetails(id)
        }
    }
}
