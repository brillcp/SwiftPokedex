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

    final class ViewModel: ViewModelProtocol {
        private var pokemon = [PokemonDetails]()

        var title: String { "Pokedex" }
        var isLoading: Bool { PokemonAPI.isLoading }
        
        func requestData(_ completion: @escaping (Result<UICollectionView.DataSource, Error>) -> Void) {
            guard !isLoading else { return }
            
            PokemonAPI.requestPokemon { result in
                switch result {
                case let .success(pokemon):
                    self.pokemon += pokemon
                    let collectionData: UICollectionView.DataSource = .pokemonDataSource(from: self.pokemon)
                    
                    DispatchQueue.main.async { completion(.success(collectionData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
