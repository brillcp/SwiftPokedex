//
//  API.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-17.
//

import Foundation
import Combine
import Networking

class API {
    static let agent = NetworkAgent()
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    static var cancellables = Set<AnyCancellable>()
    
    enum ItemType: String {
        case pokemons = "pokemon"
        case items = "item"
    }
}

extension Network.Service {

    static var `default`: Network.Service {
        Network.Service(server: ServerConfig(baseURL: "https://pokeapi.co/api/v2/"))
    }
}
