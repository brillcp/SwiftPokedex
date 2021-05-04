//
//  NavigationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

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
