//
//  DetailViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class DetailViewController: TableViewController {
    
    // MARK: Private properties
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: color], for: .normal)
        return button
    }()

    private lazy var idButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: viewModel.id, style: .plain, target: nil, action: nil)
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: color], for: .normal)
        return button
    }()
    
    private let viewModel: ViewModel
    
    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { viewModel.isLight ? .default : .lightContent }

    // MARK: - Init
    init(viewModel: ViewModel, tableData: UITableView.DataSource) {
        self.viewModel = viewModel
        super.init(tableData: tableData)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGrey
        title = viewModel.title
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = idButton

        setupTableHeader()
    }
    
    // MARK: - Private functions
    @objc private func close() {
        dismiss(animated: true)
    }
    
    private func setupTableHeader() {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300.0)
        let header = DetailHeaderView(frame: frame, pokemon: viewModel.pokemon, color: viewModel.color)
        tableView.tableHeaderView = header
    }
}
