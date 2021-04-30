import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: scene)
        
        let layout: UICollectionViewFlowLayout = .pokedexLayout
        let navigation = NavigationController(rootViewController: PokedexViewController(layout: layout))

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
