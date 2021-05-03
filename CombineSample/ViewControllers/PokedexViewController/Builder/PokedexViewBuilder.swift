import UIKit

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
