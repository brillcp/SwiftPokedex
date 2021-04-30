import UIKit

extension PokemonViewController {

    struct ViewModel {
        let type: PokemonAPI.PokemonType

        var title: String { "\(type.rawValue.capitalized) pokemon" }

        func requestPokemon(_ completion: @escaping (Result<TableDataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemon(type: type) { result in
                switch result {
                case let .success(response):
                    let pokemon = response.pokemon.sorted(by: { $0.pokemon.name < $1.pokemon.name })

                    let cells = pokemon.map { CellConfiguration<PokemonCell, Pokemon>(data: $0.pokemon) }
                    let section = TableSection(items: cells)
                    let tableData = TableDataSource(sections: [section])

                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
