//
//  ItemsViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsViewController: TableViewController<ItemCell> {

    private let viewModel = ViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkGrey
        tableView.separatorColor = .darkGray
        title = viewModel.title
        
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
