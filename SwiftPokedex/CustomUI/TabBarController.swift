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
        let pokedexView = PokedexViewBuilder.build()
        pokedexView.tabBarItem = UITabBarItem(title: "Pokedex", image: UIImage(named: "pokedex-icon"), tag: 0)

        let itemsView = ItemListBuilder.build()
        itemsView.tabBarItem = UITabBarItem(title: "Items", image: UIImage(named: "items-icon"), tag: 1)
        setViewControllers([pokedexView, itemsView], animated: false)
    }
}
