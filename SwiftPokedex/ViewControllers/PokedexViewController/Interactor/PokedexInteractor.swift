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
    private let router: PokedexRouterProtocol
    private var transition: CardTransition!
    
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

        let cardPresentationFrameOnScreen = cellSuperview.convert(cellFrame, to: nil)
        
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let x = center.x - size.width / 2
            let y = center.y - size.height / 2
            let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
            return cellSuperview.convert(rect, to: nil)
        }()
        
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell,
                                           image: cell.image,
                                           color: color)
        
        transition = CardTransition(params: params)

        router.routeToDetailView(transition: transition, pokemon: pokemon, color: color)
    }
}
