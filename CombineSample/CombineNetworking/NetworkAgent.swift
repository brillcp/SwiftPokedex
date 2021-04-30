import Foundation
import Combine

final class NetworkAgent<T: Decodable> {
    private var cancellables = Set<AnyCancellable>()
    
    func execute(_ request: URLRequest, _ completion: @escaping (Result<T, Error>) -> Swift.Void) {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue(label: "some.background.queue", qos: .background))
            .eraseToAnyPublisher()
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
