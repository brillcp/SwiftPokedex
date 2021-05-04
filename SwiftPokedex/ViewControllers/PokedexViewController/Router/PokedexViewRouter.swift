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

final class PokedexRouter: PokedexRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToDetailView(pokemon: PokemonDetails, color: UIColor) {
        let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
