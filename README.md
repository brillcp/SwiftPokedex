#SwiftPokedex

Is a simple iOS app written by Viktor Gidlöf that implements the PokeAPI.

##Architecture SwiftPokedex is written in my own interpretation of the RIB archtitecure created by Uber. The name RIBs is short for Router, Interactor and Builder, which are core components of the architecture.

##Builder The builder build the views with all of their dependencies (if any):

final class PokedexViewBuilder {
    
    static func build() -> NavigationController {
        let router = PokedexRouter()
        let interactor = PokedexInteractor(router: router)
        let viewController = PokedexViewController(interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        
        router.navigationController = navigationController
        return navigationController
    }
}
##Interactor The interactor is the link between the user input and the view and includes all the interactors that the user can make. It also contains a router object.

##Router The router is simply in charge of navigation. And since the router is decoupled from the view controller we can easily navigate to anywhere in the app.

func routeToDetailView(pokemon: PokemonDetails, color: UIColor) {
    let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
    navigationController?.pushViewController(detailView, animated: true)
}
#Requirements

Xcode 12.0+
iOS 14.0+
Swift 5+
