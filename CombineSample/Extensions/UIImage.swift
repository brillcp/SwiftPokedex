import UIKit

extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector])
        else { return nil }
        
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        
        guard let null = kCFNull else { return nil }
        
        let context = CIContext(options: [.workingColorSpace: null])
        
        let bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: bounds, format: .RGBA8, colorSpace: nil)

        let red = CGFloat(bitmap[0]) / 255.0
        let green = CGFloat(bitmap[1]) / 255.0
        let blue = CGFloat(bitmap[2]) / 255.0
        let alpha = CGFloat(bitmap[3]) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    static func load(from urlString: String, _ completion: @escaping (UIImage?) -> Swift.Void) {
        DispatchQueue.global(qos: .userInitiated).async {
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
