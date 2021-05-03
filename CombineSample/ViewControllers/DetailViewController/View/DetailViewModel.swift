import UIKit

extension DetailViewController {

    final class ViewModel: ViewModelProtocol {
        let pokemon: APIItem
        let color: UIColor?

        var title: String { pokemon.name.capitalized }
        var isLight: Bool { color?.isLight ?? true }
        var spriteURL: String?
        
        init(pokemon: APIItem, color: UIColor?) {
            self.pokemon = pokemon
            self.color = color
        }
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
            PokemonAPI.requestPokemonDetails(from: pokemon.url) { result in
                switch result {
                case let .success(response):
                    self.spriteURL = response.sprite.url
                    
                    let types: DetailCellConfig = .typesCell(values: response.types)
                    let weight: DetailCellConfig = .weightCell(value: response.weight)
                    let height: DetailCellConfig = .heightCell(value: response.height)
                    let abilities: DetailCellConfig = .abilitiesCell(values: response.abilities)
                    let infoSection = UITableView.Section(title: "Info", items: [types, weight, height, abilities])
                    
                    let stats = response.stats
                        .filter {$0.stat.name != "special-attack" && $0.stat.name != "special-defense" }
                        .map { DetailCellConfig(data: DetailItem(title: $0.stat.name.cleaned, value: "\($0.baseStat)" )) }
                    
                    let statSection = UITableView.Section(title: "Base Stats", items: stats)
                    let tableData = UITableView.DataSource(sections: [infoSection, statSection])
                    
                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
