//
//  ItemCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemCell: UITableViewCell, ConfigurableCell {

    // MARK: Private properties
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

    private lazy var detailLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .pixel14
        return label
    }()

    // MARK: - Public properties
    var data: ItemDetails?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        let margin: CGFloat = 20.0
        
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            itemImageView.widthAnchor.constraint(equalToConstant: 60.0),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
        ])
        
        contentView.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10.0),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Layout
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
    // MARK: - Public functions
    func configure(with item: ItemDetails) {
        self.data = item
        
        titleLabel.text = item.name.cleaned
        detailLabel.attributedText = item.effect.first?.description.cleaned.lineHeight(4)
        
        UIImage.load(from: item.sprites.default) { [weak self] image in
            DispatchQueue.main.async { self?.itemImageView.image = image }
        }
    }
}
