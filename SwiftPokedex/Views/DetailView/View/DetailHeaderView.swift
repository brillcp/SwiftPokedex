//
//  DetailHeaderView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// The header view for the detail view
final class DetailHeaderView: UICollectionReusableView {

    // MARK: Private properties
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(useAutolayout: true)
        let typeLabel = UILabel(useAutolayout: true)
        typeLabel.textAlignment = .center
        typeLabel.text = "Type\n\n\(String.types(from: pokemon.types))"
        typeLabel.textColor = isLight ? .black : .white
        typeLabel.numberOfLines = 4
        typeLabel.font = .pixel14
        stack.addArrangedSubview(typeLabel)

        let weightLabel = UILabel(useAutolayout: true)
        weightLabel.textAlignment = .center
        weightLabel.text = "Weight\n\n\(pokemon.weight.kilo)"
        weightLabel.numberOfLines = 3
        weightLabel.textColor = isLight ? .black : .white
        weightLabel.font = typeLabel.font
        stack.addArrangedSubview(weightLabel)

        let heightLabel = UILabel(useAutolayout: true)
        heightLabel.textAlignment = .center
        heightLabel.text = "Height\n\n\(pokemon.height.meter)"
        heightLabel.numberOfLines = 3
        heightLabel.textColor = isLight ? .black : .white
        heightLabel.font = typeLabel.font
        stack.addArrangedSubview(heightLabel)
        return stack
    }()

    private let pokemon: PokemonDetails
    private let isLight: Bool

    // MARK: - Public properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(useAutolayout: true)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Init
    init(frame: CGRect, pokemon: PokemonDetails, color: UIColor) {
        self.pokemon = pokemon
        self.isLight = color.isLight

        super.init(frame: frame)

        backgroundColor = .darkGrey

        let fillerView = UIView(frame: UIScreen.main.bounds)
        fillerView.backgroundColor = color
        fillerView.frame.origin.y -= fillerView.frame.height - frame.height
        fillerView.roundedView(corners: [.bottomLeft, .bottomRight], radius: PokedexCell.CornerRadius.large)
        addSubview(fillerView)

        addSubview(imageView)
        imageView.pinToSuperview(with: UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0), edges: .all)

        let padding: CGFloat = 20.0
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])

        ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { [weak self] _, image in
            self?.imageView.image = image
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
