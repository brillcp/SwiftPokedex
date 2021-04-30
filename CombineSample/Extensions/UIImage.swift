import UIKit

extension UIImage {
    
    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> Swift.Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let imageURL = URL(string: urlString) else { DispatchQueue.main.async { completion(nil) }; return }
            let request = URLRequest(url: imageURL)

            let cache = URLCache.shared
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                URLSession.shared.dataTask(with: request) { data, response, _ in
                    guard let data = data, let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 300, let image = UIImage(data: data)
                    else { DispatchQueue.main.async { completion(nil) }; return }

                    let cachedImage = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedImage, for: request)
                    DispatchQueue.main.async { completion(image) }
                }.resume()
            }
        }
    }
}
