//
//  PokedexViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

protocol ViewModelProtocol {
    associatedtype Data
    func requestData(_ completion: @escaping (Result<Data, Error>) -> Swift.Void)
}
    
extension PokedexViewController {

    struct ViewModel: ViewModelProtocol {
        var title: String { "Pokedex" }

        func requestData(_ completion: @escaping (Result<UICollectionView.DataSource, Error>) -> Void) {
            PokemonAPI.allPokemon { result in
                switch result {
                case let .success(pokemon):
                    let sorted = pokemon.sorted(by: { $0.id < $1.id })
                    let items = sorted.map { CollectionCellConfiguration<PokedexCell, PokemonDetails>(data: $0) }
                    let section = UICollectionView.Section(items: items)
                    let collectionData = UICollectionView.DataSource(sections: [section])
                    DispatchQueue.main.async { completion(.success(collectionData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
