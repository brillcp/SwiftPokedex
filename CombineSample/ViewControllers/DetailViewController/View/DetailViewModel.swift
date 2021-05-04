import UIKit

extension DetailViewController {

    struct ViewModel {
        let pokemon: PokemonDetails
        let color: UIColor

        var title: String { pokemon.name.capitalized }
        var isLight: Bool { color.isLight }
        var spriteURL: String { pokemon.sprite.url }
    }
}
