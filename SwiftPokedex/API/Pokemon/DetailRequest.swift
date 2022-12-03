//
//  DetailRequest.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-30.
//

import Networking

/// An enum for requesting pokemon detail data
enum DetailRequest: Requestable {
    case details(String)

    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }

    var endpoint: EndpointType {
        switch self {
        case .details(let id): return Endpoint.details(id)
        }
    }
}
