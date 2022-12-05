//
//  PokedexView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-11-30.
//

import UIKit
import Combine

/// The `PokedexView` implementation
final class PokedexView: UIView, ViewModable, Interactable, CollectionViewable {

    typealias Item = PokemonDetails
    typealias Section = String

    // MARK: Private properties
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var pokedexCollectionView: UICollectionView!

    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var collectionView: UICollectionView { pokedexCollectionView }
    var dataSource: DiffableDataSource<Section, Item>!

    enum Interaction {
        case selectPokemon(PokemonContainer)
        case scrollToBottom
    }

    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = collectionView.pokedexDataSource(data: viewModel.pokemon, delegate: self)
        collectionView.backgroundColor = .darkGrey

        viewModel.$pokemon.sink { [weak self] pokemon in
            self?.appendData(pokemon)
        }.store(in: &cancellables)
    }

    // MARK: - Private functions
    private func appendData(_ data: [PokemonDetails]) {
        var snapshot = dataSource.snapshot()
        var items = snapshot.itemIdentifiers
        items.append(contentsOf: data)
        items.sort(by: { $0.id < $1.id })
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: -
extension PokedexView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell,
              let pokemon = dataSource.itemIdentifier(for: indexPath)
        else { return }

        ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { [weak self] _, image in
            let container = PokemonContainer(pokemon: pokemon, cell: cell, image: image)
            self?.subject.send(.selectPokemon(container))
        }
    }
}

// MARK: -
extension PokedexView {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.hasScrolledToBottom else { return }
        subject.send(.scrollToBottom)
    }
}
