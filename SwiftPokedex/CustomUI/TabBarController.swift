//
//  TabBarController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        
        tabBar.barTintColor = .darkGrey
        tabBar.tintColor = .pokedexRed
        tabBar.isTranslucent = false
    }
    
    // MARK: - Private functions
    private func setupTabbar() {
        let pokedexView = PokedexViewBuilder.build()
        pokedexView.tabBarItem = .pokedex(title: "Pokedex")

        let itemsView = ListBuilder.build()
        itemsView.tabBarItem = .items(title: "Items")
        setViewControllers([pokedexView, itemsView], animated: false)
    }
}
