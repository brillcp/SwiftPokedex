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

    private lazy var detailLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .pixel12
        return label
    }()

    var data: ItemDetails?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 60.0),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
        
        contentView.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10.0),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
    // MARK: - Functions
    func configure(with item: ItemDetails) {
        self.data = item
        
        titleLabel.text = item.name.cleaned
        detailLabel.text = item.effect.first?.description
        
        UIImage.load(from: item.sprites.default) { [weak self] image in
            self?.itemImageView.image = image
        }
    }
}
