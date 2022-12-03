//
//  PokedexCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class PokedexCell: UICollectionViewCell {

    // MARK: Public properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        return imageView
    }()

    lazy var indexLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .right
        label.textColor = .white
        label.font = .pixel14
        label.alpha = 0.0
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .center
        label.textColor = .white
        label.font = .pixel17
        label.alpha = 0.0
        return label
    }()

    enum CornerRadius {
        static let large: CGFloat = 40.0
        static let small: CGFloat = 20.0
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .darkGray

        contentView.addSubview(imageView)
        imageView.pinToSuperview(with: UIEdgeInsets(top: 0, left: 0, bottom: 14.0, right: 0), edges: .all)

        contentView.addSubview(indexLabel)
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            indexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14.0)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = PokedexCell.CornerRadius.small
        clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Public functions
    func setupImage(_ image: UIImage?) {
        imageView.image = image

        let color = image?.dominantColor ?? .darkGray
        titleLabel.textColor = color.isLight ? .black : .white
        indexLabel.textColor = color.isLight ? .black : .white
        imageView.image = image
        backgroundColor = color

        guard imageView.alpha != 1.0 else { return }

        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = 1.0
            self.indexLabel.alpha = 1.0
            self.titleLabel.alpha = 1.0
        }
    }
}
