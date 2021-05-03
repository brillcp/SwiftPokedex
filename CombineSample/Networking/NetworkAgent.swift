import Foundation
import Combine

final class NetworkAgent {
    private var cancellables = Set<AnyCancellable>()
    
    func execute<T: Decodable>(_ request: URLRequest, logJSON: Bool = false, completion: @escaping (Result<T, Error>) -> Swift.Void) {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                if logJSON { print($0.data.prettyJSON ?? "no json") }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { completed in
                switch completed {
                case let .failure(error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { data in
                completion(.success(data))
            }
            .store(in: &cancellables)
    }
}
