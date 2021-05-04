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
        
        interactor.selectItem(at: indexPath, in: tableView)
    }
}
