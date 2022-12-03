//
//  ImageView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-03.
//

import UIKit

extension Transition.Animator {
    /// A custom image view used in the custom transition
    final class Image: UIImageView {
        /// Init the ImageView
        /// - parameters:
        ///     - frame: The given frame for the view
        ///     - image: An optional image
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
