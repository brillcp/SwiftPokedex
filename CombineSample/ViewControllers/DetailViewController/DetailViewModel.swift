import UIKit

extension DetailViewController {

    final class ViewModel {
        let pokemon: Pokemon
        var title: String { pokemon.name.capitalized }
        var spriteURL: String?
        
        init(pokemon: Pokemon) {
            self.pokemon = pokemon
        }
        
        func requestPokemon(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Swift.Void) {
            PokemonAPI.requestPokemonDetails(from: pokemon.url) { result in
                switch result {
                case let .success(response):
                    self.spriteURL = response.sprites.imageURL
                    
                    let weight = TableCellConfiguration<DetailCell, DetailItem>(data: DetailItem(title: "Weight", value: response.weight))
                    let height = TableCellConfiguration<DetailCell, DetailItem>(data: DetailItem(title: "Height", value: response.height))
                    let xp = TableCellConfiguration<DetailCell, DetailItem>(data: DetailItem(title: "Base XP", value: response.baseExperience))
                    let section = UITableView.Section(title: "Stats", items: [weight, height, xp])

                    let tableData = UITableView.DataSource(sections: [section])

                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}
