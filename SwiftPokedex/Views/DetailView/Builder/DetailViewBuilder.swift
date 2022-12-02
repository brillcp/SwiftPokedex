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
        navigationController.setNavbarApp(color: viewModel.color)
        return navigationController
    }
}
