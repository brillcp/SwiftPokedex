import UIKit

extension TypesViewController {

    struct ViewModel {
        let title: String
        
        func loadData(_ completion: @escaping (TableDataSource) -> Swift.Void) {
            let cells = PokemonAPI.PokemonType.allCases.map { CellConfiguration<TypeCell, PokemonAPI.PokemonType>(data: $0) }
            let section = TableSection(items: cells)
            let tableData = TableDataSource(sections: [section])
            completion(tableData)
        }
    }
}
