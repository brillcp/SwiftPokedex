import UIKit

extension ViewController {

    struct ViewModel {
        let title: String
        
        func requestPokemon(type: PokemonAPI.PokemonType, _ completion: @escaping (Result<TableDataSource, Error>) -> Swift.Void) {
            do {
                let response = try PokemonAPI.requestPokemon(type: type)
                let pokemon = response.pokemon.sorted(by: { $0.pokemon.name < $1.pokemon.name })

                let cells = pokemon.map { CellConfiguration<PokemonCell, Pokemon>(data: $0.pokemon) }
                let section = TableSection(items: cells)
                let tableData = TableDataSource(sections: [section])

                completion(.success(tableData))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
