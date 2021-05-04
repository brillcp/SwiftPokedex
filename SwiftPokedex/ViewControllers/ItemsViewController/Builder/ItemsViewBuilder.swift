import Foundation

final class ItemsViewBuilder {
    
    static func build() -> NavigationController {
        let viewController = ItemsViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
