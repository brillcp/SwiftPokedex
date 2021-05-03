import UIKit

final class DetailViewBuilder {
    
    static func build(from pokemon: Item, withColor color: UIColor?) -> DetailViewController {
        let viewModel = DetailViewController.ViewModel(pokemon: pokemon, color: color)
        return DetailViewController(viewModel: viewModel)
    }
}
