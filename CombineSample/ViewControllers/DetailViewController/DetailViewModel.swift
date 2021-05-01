import UIKit

extension DetailViewController {

    final class ViewModel {
        let pokemon: Item
        let color: UIColor?

        var title: String { pokemon.name.capitalized }
        var spriteURL: String?
        
        init(pokemon: Item, color: UIColor?) {
            self.pokemon = pokemon
            self.color = color
        }
        
        func requestPokemonDetails(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemonDetails(from: pokemon.url) { result in
                switch result {
                case let .success(response):
                    self.spriteURL = response.sprites.imageURL
                    
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
