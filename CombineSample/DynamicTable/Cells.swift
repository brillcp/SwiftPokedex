import UIKit

final class PokemonCell: UITableViewCell, ConfigurableCell {
    var data: Pokemon?
    
    func configure(with pokemon: Pokemon) {
        self.data = pokemon
        textLabel?.text = pokemon.name.capitalized
        accessoryType = .disclosureIndicator
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
