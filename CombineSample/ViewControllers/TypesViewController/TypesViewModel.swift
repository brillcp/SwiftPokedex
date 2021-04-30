import UIKit

extension TypesViewController {

    struct ViewModel {
        let title: String
        
        func loadData(_ completion: @escaping (UITableView.DataSource) -> Swift.Void) {
            let types = PokemonAPI.PokemonType.allCases.sorted(by: { $0.rawValue < $1.rawValue })
            let cells = types.map { CellConfiguration<TypeCell, PokemonAPI.PokemonType>(data: $0) }
            let section = UITableView.Section(items: cells)
            let tableData = UITableView.DataSource(sections: [section])
            completion(tableData)
        }
    }
}
