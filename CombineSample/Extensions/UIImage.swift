import UIKit
import Combine

fileprivate var cancellables = Set<AnyCancellable>()

extension UIImage {
    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> Swift.Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
            let request = URLRequest(url: imageURL)

            let cache = URLCache.shared
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { (response: $0.response, data: $0.data) }
                    .sinkToResult { result in
                        switch result {
                        case let .success(value):
                            let image = UIImage(data: value.data)
                            let cachedImage = CachedURLResponse(response: value.response, data: value.data)
                            cache.storeCachedResponse(cachedImage, for: request)
                            DispatchQueue.main.async { completion(image) }
                        case .failure:
                            DispatchQueue.main.async { completion(nil) }
                        }
                    }.store(in: &cancellables)
            }
        }
    }
}
