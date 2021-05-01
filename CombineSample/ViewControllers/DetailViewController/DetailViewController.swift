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
        
        tableView.separatorStyle = .none
        view.backgroundColor = .darkGrey
        title = viewModel.title
        
        viewModel.requestPokemonDetails { [weak self] result in
            switch result {
            case let .success(tableData):
                self?.tableData = tableData
                self?.setupTableHeader()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = viewModel.color
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.barTintColor = .pokedexRed
        navigationController?.navigationBar.shadowImage = nil
    }
    
    // MARK: - Functions
    private func setupTableHeader() {
        guard let imageURL = viewModel.spriteURL else { return }
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 320)
        tableView.tableHeaderView = .detailHeader(frame: frame, imageURL: imageURL, backgroundColor: viewModel.color)
    }
}
