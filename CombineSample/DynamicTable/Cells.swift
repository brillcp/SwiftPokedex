import UIKit

final class PokemonCell: UITableViewCell, ConfigurableCell {
    var data: Pokemon?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = imageView?.frame.width ?? 0.0
        imageView?.layer.cornerRadius = width / 2.0
        imageView?.clipsToBounds = true
    }
    
    func configure(with pokemon: Pokemon) {
        self.data = pokemon
        
        textLabel?.text = pokemon.name.capitalized
        accessoryType = .disclosureIndicator
        
        imageView?.image = UIImage(named: "placeholder")
            
        PokemonAPI.loadPokemonSprite(from: pokemon.url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(image): self?.imageView?.image = image
                case .failure: break
                }
            }
        }
    }
}

final class TypeCell: UITableViewCell, ConfigurableCell {
    var data: PokemonAPI.PokemonType?
    
    func configure(with type: PokemonAPI.PokemonType) {
        self.data = type
        
        textLabel?.text = type.rawValue.capitalized
        accessoryType = .disclosureIndicator
    }
}

final class DetailCell: UITableViewCell, ConfigurableCell {
    var data: String?
    
    func configure(with type: String) {
        self.data = type
        
        textLabel?.text = type
        selectionStyle = .none
    }
}

final class IntCell: UITableViewCell, ConfigurableCell {
    var data: Int?
    
    func configure(with type: Int) {
        self.data = type
        
        textLabel?.text = "\(type)"
        selectionStyle = .none
    }
}

