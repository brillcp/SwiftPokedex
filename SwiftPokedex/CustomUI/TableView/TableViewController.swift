//
//  TableViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

class TableViewController<Cell: UITableViewCell>: UITableViewController {

    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        return spinner
    }()
    
    //MARK: - Public properties
    var tableData: UITableView.DataSource {
        didSet {
            spinner.stopAnimating()
            tableView.reloadData()
        }
    }
    
    // MARK: - Init
    init(style: UITableView.Style = .insetGrouped, tableData: UITableView.DataSource = .init()) {
        self.tableData = tableData
        super.init(style: style)
        
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .darkGrey
        tableView.separatorColor = .darkGray
        tableView.backgroundView = spinner
        tableView.indicatorStyle = .white
        tableView.registerCell(Cell.self)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - TableView Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableData.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.numberOfItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = tableData.title(in: section) else { return nil }
        return UIView.tableHeader(title: title, in: tableView)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let title = tableData.title(in: section) else { return 0.0 }
        return UIView.tableHeader(title: title, in: tableView).frame.height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableData.item(at: indexPath).rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableData.item(at: indexPath)
        let cell = tableView.dequeueCell(for: item)
        
        item.configureCell(cell)
        return cell
    }
}
