//
//  DetailViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class DetailViewController: TableViewController<DetailCell> {
    
    private let viewModel: ViewModel
    
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
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300.0)
        let header = DetailHeaderView(frame: frame, urlString: viewModel.spriteURL, color: viewModel.color)
        tableView.tableHeaderView = header
    }
    
    private func viewWillAppear() {
        navigationController?.navigationBar.barTintColor = viewModel.color
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let idBarButton = UIBarButtonItem(title: viewModel.id, style: .plain, target: nil, action: nil)
        let color: UIColor = viewModel.isLight ? .black : .white
        idBarButton.setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: color], for: .normal)
        navigationItem.rightBarButtonItem = idBarButton

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
