import UIKit

protocol PokedexRouterProtocol {
    func routeToDetailView(pokemon: PokemonDetails, color: UIColor)
}

final class PokedexRouter: PokedexRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToDetailView(pokemon: PokemonDetails, color: UIColor) {
        let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
        
        let viewController = ViewController(pokemon: pokemon)
        
        navigationController?.pushViewController(detailView, animated: true)
    }
}

final class ViewController: UIViewController {
    
    private let pokemon: PokemonDetails
    
    init(pokemon: PokemonDetails) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: view.frame)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.pinToSuperview()
        
        UIImage.load(from: pokemon.sprite.url) { image in
            imageView.image = image
        }
    }
}
