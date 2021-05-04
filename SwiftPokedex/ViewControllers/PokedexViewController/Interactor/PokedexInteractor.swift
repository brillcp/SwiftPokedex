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

final class PokedexInteractor: PokedexInteractorProtocol {
    
    private let router: PokedexRouterProtocol
    
    init(router: PokedexRouterProtocol) {
        self.router = router
    }
    
    func selectPokemon(at indexPath: IndexPath, in collectionView: UICollectionView) {
        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell, let pokemon = cell.data, let color = cell.backgroundColor else { return }

        router.routeToDetailView(pokemon: pokemon, color: color)
    }
}
