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
            guard let self = self else { return }
            var snapshot = self.dataSource.snapshot()
            var items = snapshot.itemIdentifiers
            items.append(contentsOf: pokemon)
            items.sort(by: { $0.id < $1.id })
            snapshot.appendItems(items)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }.store(in: &cancellables)

        viewModel.$state.sink { state in
            switch state {
            case .idle:
                ()
            case .loading:
                ()
            }
        }.store(in: &cancellables)
    }
}

// MARK: -
extension PokedexView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell,
              let pokemon = dataSource.itemIdentifier(for: indexPath),
              let cellFrame = cell.layer.presentation()?.frame,
              let convertedFrame = cell.superview?.convert(cellFrame, to: nil)
        else { return }

        ImageCache.default.loadImage(from: pokemon.sprite.url, item: pokemon) { [weak self] _, image in
            guard let image = image, let color = image.dominantColor else { return }
            let container = PokemonContainer(pokemon: pokemon,
                                               image: image,
                                               frame: convertedFrame,
                                               color: color)

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
