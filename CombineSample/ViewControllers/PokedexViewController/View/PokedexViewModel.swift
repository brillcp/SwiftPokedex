import UIKit

protocol ViewModelProtocol {
    associatedtype Data
    func requestData(_ completion: @escaping (Result<Data, Error>) -> Swift.Void)
}
    
extension PokedexViewController {

    struct ViewModel: ViewModelProtocol {
        var title: String { "Pokedex" }

        func requestData(_ completion: @escaping (Result<UICollectionView.DataSource, Error>) -> Void) {
            PokemonAPI.request(.pokemons) { result in
                switch result {
                case let .success(response):
                    let pokemon = response.results
                    let cells = pokemon.map { CollectionCellConfiguration<PokedexCell, APIItem>(data: $0) }
                    let section = UICollectionView.Section(items: cells)
                    let tableData = UICollectionView.DataSource(sections: [section])
                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
