import UIKit

final class DetailViewController: TableViewController<DetailCell> {
    
    private let viewModel: ViewModel
    
    // MARK: - Init
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        viewModel.requestPokemon { result in
            switch result {
            case .success(let tableData): self.tableData = tableData
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
