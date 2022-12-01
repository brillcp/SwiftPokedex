//
//  DetailViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class DetailViewBuilder {
    
    static func build(from pokemon: PokemonDetails, withColor color: UIColor) -> NavigationController {
//        let viewModel = DetailController.ViewModel(pokemon: pokemon, color: color)
//
//        let abilities: DetailCellConfig = .abilitiesCell(values: pokemon.abilities)
//        let moves: DetailCellConfig = .movesCell(values: pokemon.moves)
//        let infoSection = UITableView.Section(title: "Info", items: [abilities])
//
//        let stats: [TableCellConfiguration] = pokemon.stats
//            .filter {$0.stat.name != "special-attack" && $0.stat.name != "special-defense" }
//            .map { .statCell(title: $0.stat.name.cleaned, value: $0.baseStat) }
//
//        let statSection = UITableView.Section(title: "", items: stats)
//        let movesSection = UITableView.Section(items: [moves])
//
//        let tableData = UITableView.DataSource(sections: [statSection, infoSection, movesSection])

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
