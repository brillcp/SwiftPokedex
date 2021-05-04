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
        tabBar.isTranslucent = false
        tabBar.tintColor = .pokedexRed
    }
    
    // MARK: - Private functions
    private func setupTabbar() {
        let pokedexView = PokedexViewBuilder.build()
        pokedexView.tabBarItem = .pokedex(title: "Pokedex")

        let itemsView = ItemListBuilder.build()
        itemsView.tabBarItem = .items(title: "Items")
        setViewControllers([pokedexView, itemsView], animated: false)
    }
}
