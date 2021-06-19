//
//  PokedexInteractor.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol PokedexInteractorProtocol {
    func selectPokemon(at indexPath: IndexPath, in collectionView: UICollectionView)
}

// MARK: -
final class PokedexInteractor: PokedexInteractorProtocol {
    
    // MARK: Private properties
    private var transition: UIViewControllerTransitioningDelegate?
    private let router: PokedexRouterProtocol
    
    // MARK: - Init
    init(router: PokedexRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Public functions
    func selectPokemon(at indexPath: IndexPath, in collectionView: UICollectionView) {
        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell,
              let pokemon = cell.data,
              let color = cell.backgroundColor,
              let cellSuperview = cell.superview,
              let cellFrame = cell.layer.presentation()?.frame
        else { return }

        let convertedCellFrame = cellSuperview.convert(cellFrame, to: nil)
        let params = TransitionController.Parameters(cellFrame: convertedCellFrame, image: cell.asImage(), color: color)
        transition = TransitionController(parameters: params)
        
        router.routeToDetailView(transition: transition, pokemon: pokemon, color: color)
    }
}
