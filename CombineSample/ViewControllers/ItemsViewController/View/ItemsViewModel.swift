import UIKit

extension ItemsViewController {
    
    struct ViewModel: ViewModelProtocol {
        var title: String { "Items" }
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
            PokemonAPI.allItems { result in
                switch result {
                case let .success(items):
                    let cells = items.map { TableCellConfiguration<ItemCell, ItemDetails>(data: $0, rowHeight: UITableView.automaticDimension) }
                    let section = UITableView.Section(items: cells)
                    let tableData = UITableView.DataSource(sections: [section])
                    DispatchQueue.main.async { completion(.success(tableData)) }
                case let .failure(error):
                    DispatchQueue.main.async { completion(.failure(error)) }
              
                }
            }
        }
    }
}
