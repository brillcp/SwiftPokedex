//
//  PokedexRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol PokedexRouterProtocol {
    func routeToDetailView(pokemon: PokemonDetails, color: UIColor)
}

// MARK: -
final class PokedexRouter: PokedexRouterProtocol {
    
    // MARK: Public properties
    weak var navigationController: UINavigationController?
    
    // MARK: - Public functions
    func routeToDetailView(pokemon: PokemonDetails, color: UIColor) {
        let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
