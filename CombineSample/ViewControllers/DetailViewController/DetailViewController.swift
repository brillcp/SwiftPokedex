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
        
        viewModel.requestPokemon { [weak self] result in
            switch result {
            case let .success(tableData):
                self?.tableData = tableData
                self?.setupTableHeader()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Functions
    private func setupTableHeader() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        guard let imageURL = viewModel.spriteURL else { return }
        
        tableView.tableHeaderView = .detailHeader(frame: frame, imageURL: imageURL)
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cell(at: indexPath) as? PokemonCell, let pokemon = cell.data else { return }

        let viewModel = DetailViewController.ViewModel(pokemon: pokemon)
        let detailView = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
