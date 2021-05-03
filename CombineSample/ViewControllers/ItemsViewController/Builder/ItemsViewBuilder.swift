import Foundation

final class ItemsViewBuilder {
    
    static func build() -> NavigationController {
        let viewController = ItemsViewController(style: .plain)
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}
