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
        label.textColor = .white
        return label
    }()

    // MARK: - Public properties
    var data: Pokemon?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.pinToSuperview()
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
