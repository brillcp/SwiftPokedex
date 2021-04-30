import UIKit

extension UINavigationController {
    
    static var mainNav: UINavigationController {
        let layout: UICollectionViewFlowLayout = .pokedexLayout
        let navigation = UINavigationController(rootViewController: PokedexViewController(layout: layout))
        navigation.navigationBar.titleTextAttributes = [.font: UIFont.pixel16, .foregroundColor: UIColor.white]
        navigation.navigationBar.barTintColor = UIColor(hex: "d53b47")
        navigation.navigationBar.isTranslucent = false
        return navigation
    }
}
