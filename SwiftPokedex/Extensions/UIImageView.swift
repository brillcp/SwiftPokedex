//
//  UIImageView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIImageView {

    static func detailImageView(frame: CGRect = .zero, image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40.0
        imageView.clipsToBounds = true
        imageView.image = image
        return imageView
    }
}
