//
//  ItemCell.swift
//  CombineSample
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemCell: UITableViewCell, ConfigurableCell {

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView(useAutolayout: true)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .white
        label.font = .pixel14
        return label
    }()

    var data: APIItem?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
        
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 60.0),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
    // MARK: - Functions
    func configure(with item: APIItem) {
        self.data = item
        
        titleLabel.text = item.name.cleaned
        
//        PokemonAPI.loadItemSprite(from: item.url) { [weak self] image in
//            self?.itemImageView.image = image
//        }
    }
}
