import Foundation
import Combine

enum NetworkTimeOutError: LocalizedError {
    case timedOut(String)
}

extension Publisher {
    private static var defaultTimeoutMessage: String { "An async operation timed out" }

    func wait(withTimeoutMessage timeoutMessage: String = defaultTimeoutMessage, forTimeInterval timeInterval: TimeInterval = 20) throws -> Output {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Output, Failure>?

        let cancellable = sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): result = .failure(error)
                case .finished: break
                }
                semaphore.signal()
            }, receiveValue: { value in
                result = .success(value)
            }
        )

        _ = semaphore.wait(timeout: .now() + timeInterval)

        guard let output = try result?.get() else {
            cancellable.cancel()
            throw NetworkTimeOutError.timedOut(timeoutMessage)
        }
        return output
    }
}
