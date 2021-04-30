import UIKit

extension UIView {
    static func detailHeader(frame: CGRect, imageURL: String) -> UIView {
        let header = UIView(frame: frame)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        
        UIImage.load(from: imageURL) { [weak imageView] image in
            imageView?.image = image
        }
        
        header.addSubview(imageView)
        return header
    }
}
