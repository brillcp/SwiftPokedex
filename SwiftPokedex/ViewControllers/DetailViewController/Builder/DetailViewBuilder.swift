//
//  DetailViewBuilder.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class DetailViewBuilder {
    
    static func build(from pokemon: PokemonDetails, withColor color: UIColor) -> DetailViewController {
        let viewModel = DetailViewController.ViewModel(pokemon: pokemon, color: color)
        
        let types: DetailCellConfig = .typesCell(values: pokemon.types)
        let weight: DetailCellConfig = .weightCell(value: pokemon.weight)
        let height: DetailCellConfig = .heightCell(value: pokemon.height)
        let abilities: DetailCellConfig = .abilitiesCell(values: pokemon.abilities)
        let moves: DetailCellConfig = .movesCell(values: pokemon.moves)
        let infoSection = UITableView.Section(title: "Info", items: [types, weight, height, abilities])

        let stats: [TableCellConfiguration] = pokemon.stats
            .filter {$0.stat.name != "special-attack" && $0.stat.name != "special-defense" }
            .map { .statCell(title: $0.stat.name.cleaned, value: $0.baseStat) }

        let statSection = UITableView.Section(title: "Base Stats", items: stats)
        let movesSection = UITableView.Section(items: [moves])
        
        let tableData = UITableView.DataSource(sections: [infoSection, statSection, movesSection])
        
        return DetailViewController(viewModel: viewModel, tableData: tableData)
    }
}
