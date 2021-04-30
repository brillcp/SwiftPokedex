import UIKit

final class TypesViewController: TableViewController<TypeCell> {
    
    private let viewModel = ViewModel(title: "Pokemon types")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        
        viewModel.loadData { data in
            self.tableData = data
        }
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cell(at: indexPath) as? TypeCell, let item = cell.data else { return }

        let viewController = PokemonViewController(viewModel: PokemonViewController.ViewModel(type: item))
        navigationController?.pushViewController(viewController, animated: true)
    }
}
