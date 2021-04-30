import Foundation
import Combine

struct NetworkAgent {
    static func makeCall<T: Decodable>(to request: URLRequest) throws -> AnyPublisher<T, Error>.Output {
        try URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue(label: "some.background.queue", qos: .background))
            .wait()
    }
}
