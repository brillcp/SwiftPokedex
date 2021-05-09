//
//  ListViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ListViewController: TableViewController<RegularCell> {
    
    private let interactor: ListInteractorProtocol
    private let viewModel = ViewModel()

    private lazy var resultsViewController = ItemsViewBuilder.build(with: ItemData(title: "", items: []))
    
    private lazy var searchController: SearchController = {
        let controller = SearchController(searchResultsController: resultsViewController)
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.searchBar.sizeToFit()
        return controller
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Init
    init(interactor: ListInteractorProtocol) {
        self.interactor = interactor
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.backButtonTitle = ""

        title = viewModel.title
        
        viewModel.requestData { [weak self] result in
            self?.spinner.stopAnimating()
            
            switch result {
            case let .success(dataSource): self?.tableData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private functions
    private func search(for text: String) {
        let lowercase = text.lowercased()
        
        let results = viewModel.items.filter {
            $0.name.cleaned.lowercased().contains(lowercase) ||
            $0.effect.description.cleaned.lowercased().contains(lowercase)
        }.sorted(by: { $0.name < $1.name })
        
        resultsViewController.tableData = .detailedItemsDataSource(from: results)
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        interactor.selectItem(at: indexPath, in: tableView)
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(for: searchText)
    }
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
