//
//  ProgressCell.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-22.
//

import UIKit

struct StatItem {
    let title: String
    let value: Int
    let color: UIColor
}

// MARK: -
final class StatCell: UITableViewCell, ConfigurableCell {

    // MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .gray
        label.font = .pixel14
        return label
    }()
    
    private lazy var statBar: StatBar = {
        let statBar = StatBar()
        statBar.translatesAutoresizingMaskIntoConstraints = false
        return statBar
    }()
    
    // MARK: - Public properties
    var data: StatItem?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50.0)
        ])
        
        contentView.addSubview(statBar)
        NSLayoutConstraint.activate([
            statBar.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20.0),
            statBar.heightAnchor.constraint(equalToConstant: 16.0),
            statBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Public functions
    func configure(with item: StatItem) {
        self.data = item
        
        titleLabel.text = item.title
        statBar.configure(with: item)
    }
}
