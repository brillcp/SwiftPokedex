//
//  PokedexViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class PokedexViewController: CollectionViewController<PokedexCell> {
    
    private let interactor: PokedexInteractorProtocol
    private let viewModel = ViewModel()

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Init
    init(interactor: PokedexInteractorProtocol) {
        self.interactor = interactor
        super.init(layout: UICollectionViewFlowLayout.pokedexLayout)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        collectionView.backgroundColor = .darkGrey
        navigationItem.backButtonTitle = ""
        
        viewModel.requestData { [weak self] result in
            switch result {
            case let .success(dataSource): self?.collectionData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Collection View Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        interactor.selectPokemon(at: indexPath, in: collectionView)        
    }
}

// MARK: - Collection View Layout
extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
}
