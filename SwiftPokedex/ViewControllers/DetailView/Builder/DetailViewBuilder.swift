//
//  DetailViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class DetailViewBuilder {

    static func build(from pokemon: PokemonDetails, withColor color: UIColor) -> NavigationController {
        let viewModel = DetailView.ViewModel(pokemon: pokemon, color: color)
        let detailView = DetailController(viewModel: viewModel)
        let navigationController = NavigationController(rootViewController: detailView)
        navigationController.navigationBar.barTintColor = viewModel.color
        navigationController.navigationBar.shadowImage = UIImage()

        if viewModel.isLight {
            navigationController.navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.black]
            navigationController.navigationBar.tintColor = .black
        }

        return navigationController
    }
}
