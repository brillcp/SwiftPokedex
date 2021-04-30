import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: scene)
        
        let layout: UICollectionViewFlowLayout = .katt
        let navigation = UINavigationController(rootViewController: PokedexViewController(layout: layout))
        navigation.navigationBar.barTintColor = UIColor(hex: "d53b47")
        navigation.navigationBar.isTranslucent = false
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

extension UICollectionViewFlowLayout {
    static var katt: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20.0
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        return layout
    }
}
