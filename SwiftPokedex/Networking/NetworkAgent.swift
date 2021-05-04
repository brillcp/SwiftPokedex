//
//  NetworkAgent.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import Foundation
import Combine

struct NetworkAgent {
    func execute<T: Decodable>(_ request: URLRequest, logJSON: Bool = false) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                if logJSON { print($0.data.prettyJSON ?? "no json") }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
