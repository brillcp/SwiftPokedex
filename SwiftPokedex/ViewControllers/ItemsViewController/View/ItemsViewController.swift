//
//  ItemsViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class ItemsViewController: TableViewController<ItemCell> {

    private let viewModel: ViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    init(viewModel: ViewModel, tableData: UITableView.DataSource) {
        self.viewModel = viewModel
        super.init(tableData: tableData)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.cleanTitle
    }
}
