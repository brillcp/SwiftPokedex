//
//  PokemonRequest.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-30.
//

import Networking

/// An enum for requesting the pokemon data
enum PokemonRequest: Requestable {
    case pokemon

    var endpoint: EndpointType { Endpoint.pokemon }
    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }
}
