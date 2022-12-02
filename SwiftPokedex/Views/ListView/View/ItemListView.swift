//
//  ItemListView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import UIKit
import Combine

final class ItemListView: UIView, ViewModable, Interactable, TableViewable {

    typealias Item = ItemData
    typealias Section = String

    // MARK: Private properties
    private lazy var resultsViewController = ItemsBuilder.build(withItemData: nil)
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var listTableView: UITableView!

    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    var tableView: UITableView { listTableView }

    lazy var searchController: SearchController = {
        let controller = SearchController(searchResultsController: resultsViewController)
        controller.searchBar.delegate = self
        return controller
    }()

    enum Interaction {
        case selectItem(ItemData)
        case search(String)
    }

    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = tableView.listViewDataSource(viewModel: viewModel, delegate: self)
        tableView.backgroundColor = .darkGrey

        viewModel.$categories.sink { [weak self] newCategories in
            guard let self = self else { return }
            var snapshot = self.dataSource.snapshot()
            var items = snapshot.itemIdentifiers
            items.append(contentsOf: newCategories)
            snapshot.appendItems(items)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }.store(in: &cancellables)
    }
}

// MARK: -
extension ItemListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        subject.send(.selectItem(item))
    }
}

// MARK: -
extension ItemListView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let categories = viewModel.categories.flatMap { $0.items }
        let filter = categories.filtered(from: searchText)
        resultsViewController.viewModel.items = filter
    }
}
