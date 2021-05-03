import UIKit

protocol PokedexRouterProtocol {
    func routeToDetailView(pokemon: Item, color: UIColor?)
}

final class PokedexRouter: PokedexRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToDetailView(pokemon: Item, color: UIColor?) {
        let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
