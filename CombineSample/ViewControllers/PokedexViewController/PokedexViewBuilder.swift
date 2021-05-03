import UIKit

final class PokedexViewBuilder {
    
    static func build() -> PokedexViewController {
        let layout: UICollectionViewFlowLayout = .pokedexLayout
        return PokedexViewController(layout: layout)
    }
}
