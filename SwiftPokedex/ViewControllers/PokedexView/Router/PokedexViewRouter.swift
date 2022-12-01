//
//  PokedexRouter.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol PokedexRouterProtocol {
    func routeToDetailView(pokemon: PokemonDetails, cellImage: UIImage?, cellFrame: CGRect, color: UIColor)
}

// MARK: -
final class PokedexRouter: PokedexRouterProtocol {
    
    // MARK: Public properties
    weak var navigationController: UINavigationController?
    
    // MARK: - Public functions
    func routeToDetailView(pokemon: PokemonDetails, cellImage: UIImage?, cellFrame: CGRect, color: UIColor) {
        let detailView = DetailViewBuilder.build(from: pokemon, withColor: color)
        let interaction = InteractionController(viewController: detailView, initialFrame: cellFrame, image: cellImage)
        let transitionManager = TransitionController(interactionController: interaction)
        detailView.transitionManager = transitionManager
        detailView.transitioningDelegate = transitionManager
        detailView.modalPresentationStyle = .custom
        navigationController?.present(detailView, animated: true)
    }
}
