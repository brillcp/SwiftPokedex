import UIKit


final class ItemsViewController: TableViewController<ItemCell> {

    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkGrey
        title = viewModel.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.requestData { [weak self] result in
            switch result {
            case let .success(dataSource): self?.tableData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ItemsViewController {
    
    struct ViewModel: ViewModelProtocol {
        var title: String { "Items" }
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
            PokemonAPI.request(.items) { result in
                switch result {
                case let .success(response):
                    let items = response.results
                    let cells = items.map { TableCellConfiguration<ItemCell, APIItem>(data: $0, rowHeight: 60.0) }
                    let section = UITableView.Section(items: cells)
                    let tableData = UITableView.DataSource(sections: [section])
                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}

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
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
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
        
        PokemonAPI.loadItemSprite(from: item.url) { [weak self] image in
            self?.itemImageView.image = image
        }
    }
}

final class ItemsViewBuilder {
    
    static func build() -> NavigationController {
        let viewController = ItemsViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
