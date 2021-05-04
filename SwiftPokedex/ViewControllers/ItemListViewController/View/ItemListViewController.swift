//
//  ItemListViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemListViewController: TableViewController<RegularCell> {
    
    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        tableView.backgroundColor = .darkGrey
        tableView.separatorColor = .darkGray
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cell(at: indexPath) as? RegularCell, let data = cell.data else { return }
        
        let view = ItemsViewBuilder.build(with: data)
        navigationController?.pushViewController(view, animated: true)
    }
}
