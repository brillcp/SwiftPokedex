import UIKit


final class ItemsViewController: TableViewController<ItemCell> {

    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkGrey
        title = viewModel.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.requestData { [weak self] result in
            switch result {
            case let .success(dataSource): self?.tableData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
