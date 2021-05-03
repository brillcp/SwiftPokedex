import UIKit

final class DetailViewBuilder {
    
    static func build(from pokemon: APIItem, withColor color: UIColor?) -> DetailViewController {
        let viewModel = DetailViewController.ViewModel(pokemon: pokemon, color: color)
        return DetailViewController(viewModel: viewModel)
    }
}
