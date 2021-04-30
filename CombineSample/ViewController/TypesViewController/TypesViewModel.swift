import UIKit

extension TypesViewController {

    struct ViewModel {
        let title: String
        
        func loadData(_ completion: @escaping (UITableView.DataSource) -> Swift.Void) {
            let cells = PokemonAPI.PokemonType.allCases.map { CellConfiguration<TypeCell, PokemonAPI.PokemonType>(data: $0) }
            let section = UITableView.Section(items: cells)
            let tableData = UITableView.DataSource(sections: [section])
            completion(tableData)
        }
    }
}
