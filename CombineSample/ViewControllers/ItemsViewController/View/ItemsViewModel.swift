import UIKit

extension ItemsViewController {
    
    struct ViewModel: ViewModelProtocol {
        var title: String { "Items" }
        
        func requestData(_ completion: @escaping (Result<UITableView.DataSource, Error>) -> Void) {
//            PokemonAPI.request(.items) { result in
//                switch result {
//                case let .success(response):
//                    let items = response.results
//                    let cells = items.map { TableCellConfiguration<ItemCell, APIItem>(data: $0, rowHeight: 60.0) }
//                    let section = UITableView.Section(items: cells)
//                    let tableData = UITableView.DataSource(sections: [section])
//                    DispatchQueue.main.async { completion(.success(tableData)) }
//                case let .failure(error):
//                    DispatchQueue.main.async { completion(.failure(error)) }
//                }
//            }
        }
    }
}
