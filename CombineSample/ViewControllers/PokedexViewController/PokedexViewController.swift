import UIKit

final class PokedexViewController: CollectionViewController<PokedexCell> {
    
    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        collectionView.backgroundColor = .darkGrey
        collectionView.indicatorStyle = .white
        
        viewModel.requestPokemons { [weak self] result in
            switch result {
            case let .success(dataSource): self?.collectionData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Collection View Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell, let pokemon = cell.data else { return }
        
        let viewModel = DetailViewController.ViewModel(pokemon: pokemon, color: cell.backgroundColor)
        let detailView = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailView, animated: true)
    }
}

// MARK: - Collection View Layout
extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
}
