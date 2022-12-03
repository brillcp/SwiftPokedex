//
//  HeaderView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-03.
//

import UIKit

/// A header view and an image view used in the custom interactive transition
extension Transition.Animator {

    final class Header: UIView {
        init(frame: CGRect, image: UIImage?, cornerRadius: CGFloat) {
            super.init(frame: frame)
            layer.cornerRadius = cornerRadius
            backgroundColor = image?.dominantColor
            alpha = 0.0
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }

    final class Image: UIImageView {
        init(frame: CGRect, image: UIImage?) {
            super.init(frame: frame)
            contentMode = .scaleAspectFill
            self.image = image
            alpha = 0.0
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }
}

// MARK: -
extension Transition.Animator.Image {
    /// Create a new size from the given multiplier and current image view frame
    /// - parameter multiplier: The multiplier to use for calculating the new size
    /// - returns: A new size from the given multiplier
    func size(fromMultiplier multiplier: CGFloat) -> CGSize {
        let newWidth: CGFloat = frame.size.width * multiplier
        let newHeight: CGFloat = frame.size.height * multiplier
        return CGSize(width: newWidth, height: newHeight)
    }
}
