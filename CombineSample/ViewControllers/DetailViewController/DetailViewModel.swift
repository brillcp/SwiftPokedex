import UIKit

extension DetailViewController {

    struct ViewModel {
        let pokemon: Pokemon
        
        var title: String { pokemon.name.capitalized }
        
        func requestPokemon(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemonDetails(from: pokemon.url) { result in
                switch result {
                case let .success(response):
                    let baseXp = CellConfiguration<IntCell, Int>(data: response.baseExperience)
                    let section = UITableView.Section(title: "Stats", items: [baseXp])
                    
                    let forms = response.forms.map { CellConfiguration<PokemonCell, Pokemon>(data: $0) }
                    let formsSection = UITableView.Section(title: "Forms", items: forms)
                    
                    let tableData = UITableView.DataSource(sections: [section, formsSection])

                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
