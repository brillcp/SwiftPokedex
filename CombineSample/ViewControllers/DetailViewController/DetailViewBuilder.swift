import UIKit

final class DetailViewBuilder {
    
    static func build(pokemon: Item, color: UIColor?) -> DetailViewController {
        let viewModel = DetailViewController.ViewModel(pokemon: pokemon, color: color)
        return DetailViewController(viewModel: viewModel)
    }
}
