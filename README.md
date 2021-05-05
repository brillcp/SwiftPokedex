![icon](https://user-images.githubusercontent.com/15960525/117062071-47808e00-ad23-11eb-83df-95d8efadac58.png)

# SwiftPokedex

SwiftPokedex is a simple Pokedex app written by [Viktor Gidlöf](https://viktorgidlof.com) in Swift that implements the [PokeAPI](https://pokeapi.co). For full documentation and implementation of the PokeAPI please have a look at the PokeAPI [documentation](https://pokeapi.co/docs/v2). It downloads an array of Pokemon and displays them in a grid. The most dominant color of the Pokemon sprite is detected and shown in the UI. It also shows a list of the most common items.


![pokdex1](https://user-images.githubusercontent.com/15960525/117063244-d3df8080-ad24-11eb-9293-83f8ba1a991a.png)
![pokedex2](https://user-images.githubusercontent.com/15960525/117063248-d4781700-ad24-11eb-8559-dcc9ebbd0ec7.png)


# Architecture

SwiftPokedex is written in my own interpretation of the RIB archtitecure created by Uber. The name RIBs is short for Router, Interactor and Builder, which are core components of the architecture.

## Builder

The builder build the views with all of their dependencies.
```swift
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
```

## Interactor
The interactor is the link between the user input and the view and includes all the interations the user can make. It also contains a router object. So when the user interacts with the view we call the interactor to make the appropriate interaction.
```swift
override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)

    interactor.selectPokemon(at: indexPath, in: collectionView)
}
```

## Router
The router is in charge of navigation. And since routers are decoupled from view controllers we can easily navigate to anywhere in the app.
```swift
func routeToDetailView(pokemon: PokemonDetails, color: UIColor) {
    let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
    navigationController?.pushViewController(detailView, animated: true)
}
```

# Networking

SwiftPokedex uses Combine for all the API calls to the PokeAPI. This small structure is all that's needed to make any type of request to the API. 
The `PokemonAPI` is then build around this network agent. It supports requesting pokemons and items at the moment.
```swift
struct NetworkAgent {
    func execute<T: Decodable>(_ request: URLRequest, logJSON: Bool = false) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                if logJSON { print($0.data.prettyJSON ?? "no json") }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
```

# Data driven tables and collection views

The table views and collection views are data driven and they setup their own UI based on the data they are given. So setting up a collection view data source is done like this:
```swift
let items = pokemon.map { CollectionCellConfiguration<PokedexCell, PokemonDetails>(data: $0) }
let section = UICollectionView.Section(items: items)
let collectionData = UICollectionView.DataSource(sections: [section])
```

By configuring the cells using `CollectionCellConfiguration` we tell the collection view that the data type we want to use is `PokemonDetails` and the custom cell is `PokedexCell`. This make setting up cells type safe as well. Then the collection view automatically renders that data with those cells. No need to implement any of the collection delegate or data source methods in the view controller. That is done with the `CollectionCellConfigurator` protocol and a subclass of `UICollectionViewController`.

# Todo

- [x] Request pokemon
- [ ] Search pokemon
- [x] Show pokemon details
- [x] Request items
- [ ] Search items 
- [x] Show item descriptions
- [ ] List pagination
- [ ] Implement other parts of the API such as:
    - Moves
    - Abilities
    - Berries

# Requirements

+ Xcode 12.0+
+ iOS 14.1+
+ Swift 5+
