//
//  DetailCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

struct DetailItem {
    let id = UUID()
    let title: String
    let value: String
}

// MARK: -
extension DetailItem: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: -
final class DetailCell: UITableViewCell {

    // MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .gray
        label.font = .pixel14
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .pixel14
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            titleLabel.widthAnchor.constraint(equalToConstant: 140.0)
        ])

        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15.0),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public functions
    func configure(withItem item: DetailItem?) {
        guard let item = item else { return }
        titleLabel.text = item.title
        valueLabel.text = item.value
        selectionStyle = .none
    }
}
