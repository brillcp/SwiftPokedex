import UIKit

final class PokedexCell: UICollectionViewCell, ConfigurableCell {
    
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .center
        label.textColor = .white
        label.font = .pixel16
        return label
    }()

    // MARK: - Public properties
    var data: Pokemon?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.pinToSuperview(with: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0), edges: .all)
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 20.0
        clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .lightGray
        imageView.image = nil
    }
    
    // MARK: - Functions
    func configure(with pokemon: Pokemon) {
        data = pokemon
        
        titleLabel.text = pokemon.name.capitalized
        
        PokemonAPI.loadPokemonSprite(from: pokemon.url) { [weak self] result in
            switch result {
            case let .success(image):
                DispatchQueue.global(qos: .userInitiated).async {
                    let colors = image?.getColors()
                    
                    DispatchQueue.main.async {
                        self?.backgroundColor = colors?.background
                        self?.imageView.image = image
                    }
                }
            case .failure: break
            }
        }
    }
}
