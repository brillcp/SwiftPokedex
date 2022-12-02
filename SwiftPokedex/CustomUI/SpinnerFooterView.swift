//
//  SpinnerFooterView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-02.
//

import UIKit

final class SpinnerFooterView: UICollectionReusableView {

    // MARK: Private properties
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(useAutolayout: true)
        spinner.color = .white
        return spinner
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(spinner)
        spinner.pinToSuperview()
        spinner.startAnimating()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
