//
//  NavigationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: Public properties
    override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.white]
        navigationBar.barTintColor = .pokedexRed
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
}
