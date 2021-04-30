import UIKit

final class PokedexViewController: CollectionViewController<PokedexCell> {
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        collectionView.backgroundColor = .darkGrey
        collectionView.indicatorStyle = .white
        
        viewModel.requestPokemon { [weak self] result in
            switch result {
            case let .success(dataSource): self?.collectionData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let cell = collectionView.cell(at: indexPath) as? PokedexCell, let item = cell.data else { return }
        
        let detailView = DetailViewController(viewModel: DetailViewController.ViewModel(pokemon: item))
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
}
