import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.white]
        navigationBar.barTintColor = .pokedexRed
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
}

extension NavigationController {
    public override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }
}
