import Combine

extension Publisher {
    public func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink { completion in
            switch completion {
            case let .failure(error): result(.failure(error))
            default: break
            }
        } receiveValue: { value in
            result(.success(value))
        }
    }
}
