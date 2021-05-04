import UIKit

final class DetailViewController: TableViewController<DetailCell> {
    
    private let viewModel: ViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle { viewModel.isLight ? .default : .lightContent }

    // MARK: - Init
    init(viewModel: ViewModel, tableData: UITableView.DataSource) {
        self.viewModel = viewModel
        super.init(style: .grouped, tableData: tableData)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        view.backgroundColor = .darkGrey
        title = viewModel.title
  
        setupTableHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappear()
    }
    
    // MARK: - Functions
    private func setupTableHeader() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        tableView.tableHeaderView = .detailHeader(frame: frame, imageURL: viewModel.spriteURL, backgroundColor: viewModel.color)
    }
    
    private func viewWillAppear() {
        navigationController?.navigationBar.barTintColor = viewModel.color
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if viewModel.isLight {
            navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.black]
            navigationController?.navigationBar.tintColor = .black
        }
    }
    
    private func viewWillDisappear() {
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: UIColor.white], for: .normal)
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .pokedexRed
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = nil
    }
}
