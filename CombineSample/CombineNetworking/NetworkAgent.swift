import Foundation
import Combine

struct NetworkAgent {
    func execute<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue(label: "some.background.queue", qos: .background))
            .eraseToAnyPublisher()
    }
}
