
> [!CAUTION]
> This repository is deprecated and no longer maintained. [Here](https://github.com/brillcp/SwiftUIPokedex/) is a new modern version written in SwftUI.

![icon](https://user-images.githubusercontent.com/15960525/117062071-47808e00-ad23-11eb-83df-95d8efadac58.png)

# SwiftPokedex 
SwiftPokedex is a simple Pokedex app written by [Viktor Gidlöf](https://viktorgidlof.com) in Swift that implements the [PokeAPI](https://pokeapi.co). For full documentation and implementation of PokeAPI have a look at the their [documentation](https://pokeapi.co/docs/v2). 

This sample app demonstrates:
+ Compositional layout for table and collection views 💾
+ Async image download and caching 🏞
+ Network capabilities using Combine ⚡️
+ Custom navigation bar and tabbar 🧭
+ Custom view transition 📲
+ RIB+VVM architecture 🏛
+ Infinite scrolling 📜
+ Custom fonts 📖

It downloads an array of Pokemon and displays them in a grid. The most dominant color of the Pokemon sprite is detected and shown in the UI. It also shows a list of the most common items.

![pokdex1](https://user-images.githubusercontent.com/15960525/117063244-d3df8080-ad24-11eb-9293-83f8ba1a991a.png)
![pokedex2](https://user-images.githubusercontent.com/15960525/117063248-d4781700-ad24-11eb-8559-dcc9ebbd0ec7.png)

# Architecture 🏛
SwiftPokedex is written in my own interpretation of the RIB archtitecure created by Uber, called RIB+VVM. RIBs is short for Router, Interactor and Builder, which are the core components of the architecture. And VVM refers to View and ViewModel.

## Builder 🛠
The builder builds the views with all of their dependencies.
```swift
final class PokedexViewBuilder {
    static func build() -> NavigationController {
        let router = PokedexRouter()
        let interactor = PokedexInteractor(router: router, service: .default)
        let viewController = PokedexController(viewModel: .init(), interactor: interactor)
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.setNavbarApp(color: .pokedexRed)
        interactor.view = viewController
        router.navigationController = navigationController
        return navigationController
    }
}
```

## View 📱
The view is a regular `UIView` and is made with a xib in this project. The upside of using a xib is that the view layout can be adapted for iPad very easily. The potential downside is that you can't really pass any custom objects to the view. But that is fixed by making the views subsrcibe to the [ViewModable](SwiftPokedex/Miscellaneous/Protocols/ViewModable.swift) protocol. That way all the objects and UI elements are set when the view model is set.
```swift
final class PokedexView: UIView, ViewModable {

    // ...
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
 
    func setViewModel(_ viewModel: ViewModel) {
        // Set all the data and state from the view model to the UI
    }
}
```

Views are also subscribing to the [Interactable](SwiftPokedex/Miscellaneous/Protocols/Interactable.swift) protocol, making them implement an interaction publisher that publish all the interactions the view can make (user input, delegate calls, etc…):
```swift
final class PokedexView: UIView, Interactable {

    private let subject: PassthroughSubject<Interaction, Never> = .init()
 
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }

    enum Interaction {
        case navigateSomewhere
        case increaseValue(Int)
    }

    // ...

    @IBAction private func buttonAction(_ sender: UIButton) {
        subject.send(.navigateSomewhere)
    }

    @IBAction private func increaseAction(_ sender: UIButton) {
        subject.send(.increaseValue(1))
    }
}
```

## View Model 🧾
The view model objects contains state and values:
```swift
final class ViewModel {
    @Published var pokemon = [PokemonDetails]()
    @Published var state: State = .idle

    enum State {
        case idle, loading
    }
}
```

And by declearing the properties as `Published` we can utilize them as Combine publishers in the view implementation:
```swift
final class PokedexView: UIView, ViewModable {

    // ...
 
    func setViewModel(_ viewModel: ViewModel) {
        // ...
        viewModel.$pokemon.sink { [weak self] pokemon in
            self?.appendData(pokemon)
        }.store(in: &cancellables)
    }
}
```

## Interactor 👇🏻
The interactor is the connection between the user input and the view and includes all the interactions that can happen in the view. Also any network calls, database communication and navigation. The interactor also changes the state of the view by calling the view's view model object directly.

The interactor has a weak reference to the view protocol that contains an interaction publisher and the view model:
```swift
protocol PokedexViewProtocol: AnyObject {
    var interaction: AnyPublisher<PokedexView.Interaction, Never> { get }
    var viewModel: PokedexView.ViewModel { get }
}
```

This way the interactor can listen to any interactions and respond with the appropriate action:
```swift
final class PokedexInteractor {

    // ...
    private var cancellables = Set<AnyCancellable>()
    private let router: Routable

    weak var view: PokedexViewProtocol? { didSet { setupInteractionPublisher() } }

    // ...
    private func setupInteractionPublisher() {
        view?.interaction.sink { [weak self] interaction in
            // Respond to the interaction from the view
            switch interaction {
            case .navigateSomewhere:
                self?.router.routeToSomeView()

            case .increaseValue(let int):
                self?.view?.viewModel.value += int
            }
        }.store(in: &cancellables)
    }
}
```

## Router 🕹
The router is in charge of navigation. And since routers are decoupled from view controllers we can easily navigate to anywhere in the app.
```swift
func routeToDetailView(withPokemonContainer container: PokemonContainer) {
    let detailView = DetailBuilder.build(fromContainer: container)
    navigationController?.present(detailView, animated: true)
}
```

# Dependencies 
SwiftPokedex uses the HTTP framework [Networking](https://github.com/brillcp/Networking) for all the API calls to the PokeAPI. You can read more about that [here](https://github.com/brillcp/Networking#readme). It can be installed through Swift Package Manager:
```
dependencies: [
    .package(url: "https://github.com/brillcp/Networking.git", .upToNextMajor(from: "0.8.9"))
]
```

# Todo 📝
The PokeAPI is very extensive and it contains a lot of things. Here are some things that can be implemented further down the line:
- [x] Request pokemon
- [ ] Search pokemon
- [x] Pokedex pagination
- [x] Show pokemon details
- [x] Request items
- [x] Search items 
- [x] Show item descriptions
- [ ] Implement other parts of the API such as:
    - Moves
    - Abilities
    - Berries

# Requirements ❗️
+ Xcode 14.0.1+
+ iOS 15.0+
+ Swift 5.7+
