//
//  HeaderView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-03.
//

import UIKit

extension TransitionAnimator {

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
extension TransitionAnimator.Image {

    func newSize(fromMultiplier multiplier: CGFloat) -> CGSize {
        let newWidth: CGFloat = frame.size.width * multiplier
        let newHeight: CGFloat = frame.size.height * multiplier
        let newSize: CGSize = CGSize(width: newWidth, height: newHeight)
        return newSize
    }
}
