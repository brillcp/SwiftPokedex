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

    static func detailHeader(frame: CGRect, imageURL: String, backgroundColor: UIColor?) -> UIView {
        let header = UIView(frame: frame)
        header.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        
        UIImage.load(from: imageURL) { [weak imageView] image in
            imageView?.image = image
        }
        
        let fillerView = UIView(frame: UIScreen.main.bounds)
        fillerView.backgroundColor = backgroundColor
        fillerView.frame.origin.y -= fillerView.frame.height - frame.height
        
        header.addSubview(fillerView)
        header.addSubview(imageView)
        
        let cornerHeight: CGFloat = 30.0
        let cornerView = UIView(frame: CGRect(x: 0, y: 0, width: header.frame.width, height: cornerHeight))
        cornerView.backgroundColor = .darkGrey
        cornerView.frame.origin.y = header.frame.height - (cornerHeight / 2)
        cornerView.roundedView(corners: [.topLeft, .topRight])
        header.addSubview(cornerView)
        
        return header
    }
    
    static func tableHeader(title: String?, in tableView: UITableView) -> UIView {
        let width = tableView.frame.width
        let headerHeight: CGFloat = 40.0
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width, height: headerHeight))

        let labelHeight: CGFloat = 20.0
        let label = UILabel(frame: CGRect(x: 15.0, y: header.frame.height - labelHeight, width: width - 40, height: labelHeight))
        label.textColor = .white
        label.font = .pixel14
        label.text = title
        header.addSubview(label)
        return header
    }
    
    
    func roundedView(corners: UIRectCorner = .allCorners, radius: CGFloat = 30.0) {
        let maskPath1 = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
