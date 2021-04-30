import UIKit

extension UIView {
    
    convenience init(useAutolayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !useAutolayout
    }

    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }

    static func detailHeader(frame: CGRect, imageURL: String) -> UIView {
        let header = UIView(frame: frame)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        
        DispatchQueue.global(qos: .userInteractive).async {
            UIImage.load(from: imageURL) { [weak imageView, weak header] image in
                let color = image?.dominantColor
                
                DispatchQueue.main.async {
                    header?.backgroundColor = color
                    imageView?.image = image
                }
            }
        }
        
        header.addSubview(imageView)
        return header
    }
}
