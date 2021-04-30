import UIKit

final class TypeCell: UITableViewCell, ConfigurableCell {
    var data: PokemonAPI.PokemonType?
    
    func configure(with type: PokemonAPI.PokemonType) {
        self.data = type
        
        textLabel?.text = type.rawValue.capitalized
        accessoryType = .disclosureIndicator
    }
}

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

struct DetailItem {
    let title: String
    let value: Int
}

final class DetailCell: UITableViewCell, ConfigurableCell {
    var data: DetailItem?
    
    func configure(with item: DetailItem) {
        self.data = item
        
        textLabel?.text = "\(item.title): \(item.value)"
        selectionStyle = .none
    }
}
