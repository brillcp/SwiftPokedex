//
//  UIImageView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-17.
//

import UIKit

extension UIImageView {

    static func detailImageView(frame: CGRect = .zero, parameters: TransitionController.Parameters) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.layer.cornerRadius = 40.0
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = parameters.color
        imageView.image = parameters.image
        return imageView
    }
}
