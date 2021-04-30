import UIKit

extension DetailViewController {

    struct ViewModel {
        let pokemon: Pokemon
        
        var title: String { pokemon.name.capitalized }
        
        func requestPokemon(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemonDetails(from: pokemon.url) { result in
                switch result {
                case let .success(response):
                    ()
//                    let baseXp = CellConfiguration<DetailCell, Int>(data: response.baseExperience)
//
//                    let section = TableSection(items: [baseXp])
//                    let tableData = TableDataSource(sections: [section])
//
//                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
