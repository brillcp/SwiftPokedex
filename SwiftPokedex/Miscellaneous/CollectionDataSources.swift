//
//  DataSources.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-03-30.
//

import UIKit

typealias DiffableDataSource = UICollectionViewDiffableDataSource
typealias Snapshot = NSDiffableDataSourceSnapshot

// MARK: -
extension UICollectionView {

    typealias SearchDataSource = DiffableDataSource<PokedexView.Section, PokedexView.Item>

    /// A diffable data source object with `AgeRangeCell` and `CategoryCell` cells.
    /// Used in the collection view in the `PokedexView`.
    /// - parameters:
    ///     - delegate: The collection view delegate
    /// - returns: A diffable data source for the collection view
    func pokedexDataSource(data: [PokemonDetails], delegate del: UICollectionViewDelegate) -> SearchDataSource {
        setCollectionViewLayout(.pokedexLayout, animated: false)
        registerReusableFooterView(SpinnerFooterView.self)
        registerCell(PokedexCell.self)
        delegate = del

        let dataSource = SearchDataSource(collectionView: self) { collectionView, indexPath, pokemon in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.identifier, for: indexPath) as? PokedexCell else { fatalError("No way, Jose 🌮") }
            cell.titleLabel.text = pokemon.name.capitalized
            cell.indexLabel.text = "#\(pokemon.id)"

            ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { fetchedPokemon, image in
                guard let currentPokemon = fetchedPokemon as? PokemonDetails, currentPokemon == pokemon else { return }
                cell.setupImage(image)
            }
            return cell
        }

        dataSource.supplementaryViewProvider = { _, _, indexPath in
            self.dequeueFooterView(SpinnerFooterView.self, at: indexPath)
        }

        var snapshot = Snapshot<PokedexView.Section, PokedexView.Item>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
        return dataSource
    }
}
