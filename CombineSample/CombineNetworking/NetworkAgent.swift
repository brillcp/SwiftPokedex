import Foundation
import Combine

struct NetworkAgent {
    static func makeCall<T: Decodable>(to request: URLRequest) throws -> AnyPublisher<T, Error>.Output {
        try URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                print($0.data.prettyJSON ?? "json failed")
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue(label: "some.background.queue", qos: .background))
            .wait()
    }
}

extension Data {
    var prettyJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else { return nil}
        return String(data: data, encoding: .utf8)
    }
}
