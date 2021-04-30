import UIKit

final class PokemonCell: UITableViewCell, ConfigurableCell {
    var data: Pokemon?
    
    func configure(with pokemon: Pokemon) {
        self.data = pokemon
        textLabel?.text = pokemon.name.capitalized
        accessoryType = .disclosureIndicator
    }
}
