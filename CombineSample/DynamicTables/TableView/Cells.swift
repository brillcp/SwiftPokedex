import UIKit

struct DetailItem {
    let title: String
    let value: String
}

final class DetailCell: UITableViewCell, ConfigurableCell {

    // MARK: - Private properties
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
    
    // MARK: - Public properties
    var data: DetailItem?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 140.0)
        ])
        
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -15.0),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])

    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Functions
    func configure(with item: DetailItem) {
        self.data = item
        
        titleLabel.text = item.title
        valueLabel.text = item.value
        selectionStyle = .none
    }
}

final class RegularCell: UITableViewCell, ConfigurableCell {
    var data: String?
    
    func configure(with item: String) {
        self.data = item
        
        textLabel?.text = item
        textLabel?.font = .pixel17
        selectionStyle = .none
    }
}

extension Int {
    
    var meter: String {
        String(format: "%.1f m", Double(self) / 10.0)
    }
    
    var kilo: String {
        String(format: "%.1f kg", Double(self) / 10.0)
    }
}
