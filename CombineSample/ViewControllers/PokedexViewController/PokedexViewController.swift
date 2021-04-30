import UIKit

final class PokedexViewController: CollectionViewController<PokedexCell> {
    
    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        collectionView.backgroundColor = UIColor(hex: "222222")
        collectionView.indicatorStyle = .white
        
        viewModel.requestPokemon { [weak self] result in
            switch result {
            case let .success(dataSource): self?.collectionData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
}
