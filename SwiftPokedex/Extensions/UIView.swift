//
//  UIView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension UIView {
    /// Create a view using auto layout
    /// - parameter useAutolayout: A bool value that determines to use auto layout
    convenience init(useAutolayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !useAutolayout
    }

    // MARK: Public functions
    /// Initialize a new `UIView` from a nib
    /// - returns: An instantiated view
    class func instanceFromNib() -> Self {
        guard let view = UINib(view: Self.self).instantiate(withOwner: nil)[0] as? Self else { fatalError("The view couldn't be instansiated. Maybe there is no nib for this view type?") }
        return view
    }

    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.right) { trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true }
        if edges.contains(.bottom) { bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true }
        if edges.contains(.left) { leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true }
        if edges.contains(.top) { topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true }
    }

    static func tableHeader(title: String?, in tableView: UITableView) -> UIView {
        let width = tableView.frame.width
        let headerHeight: CGFloat = 40.0
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width, height: headerHeight))

        let labelHeight: CGFloat = 20.0
        let label = UILabel(frame: CGRect(x: 20.0, y: header.frame.height - labelHeight, width: width - 40, height: labelHeight))
        label.textColor = .white
        label.font = .pixel14
        label.text = title
        header.addSubview(label)
        return header
    }

    func roundedView(corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let maskPath1 = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }

    func asImage(frame: CGRect? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame?.size ?? bounds.size, false, 1.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: -
extension UIView: Identifiable {}
