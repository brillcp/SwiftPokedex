import UIKit

extension PokedexViewController {

    struct ViewModel {
        var title: String { "Pokedex" }

        func requestPokemons(_ completion: @escaping (Result<UICollectionView.DataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemons { result in
                switch result {
                case let .success(response):
                    let pokemon = response.results

                    let cells = pokemon.map { CollectionCellConfiguration<PokedexCell, Item>(data: $0) }
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
