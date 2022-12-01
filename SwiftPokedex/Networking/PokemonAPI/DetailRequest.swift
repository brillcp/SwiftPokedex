//
//  DetailRequest.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-30.
//

import Networking

enum DetailRequest: Requestable {
    case details(String)

    var endpoint: EndpointType {
        switch self {
        case .details(let id): return Endpoint.details(id)
        }
    }

    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }
}
