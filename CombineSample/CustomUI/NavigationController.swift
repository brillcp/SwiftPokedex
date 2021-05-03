import UIKit

final class NavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.white]
        navigationBar.barTintColor = .pokedexRed
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
}

final class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        
        tabBar.barTintColor = .darkGrey
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
    }
    
    // MARK: - Private functions
    private func setupTabbar() {
        let wheelList = PokedexViewBuilder.build()
        let list = ItemsViewBuilder.build()
        setViewControllers([wheelList, list], animated: false)
    }
}
