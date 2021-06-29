//
//  TabBarController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
    }
    
    // MARK: - Private functions
    private func setupTabbar() {
        tabBar.barTintColor = .darkGrey
        tabBar.tintColor = .pokedexRed
        tabBar.isTranslucent = false

        let pokedexView = PokedexViewBuilder.build()
        pokedexView.tabBarItem = .pokedex(title: pokedexView.title)

        let itemsView = ListBuilder.build()
        itemsView.tabBarItem = .items(title: itemsView.title)
        setViewControllers([pokedexView, itemsView], animated: false)
    }
}
