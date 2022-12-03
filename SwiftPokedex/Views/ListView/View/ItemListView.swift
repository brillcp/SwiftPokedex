//
//  ItemListView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import UIKit
import Combine

/// The `ItemListView` implementation
final class ItemListView: UIView, ViewModable, Interactable, TableViewable {

    typealias Item = ItemData
    typealias Section = String

    // MARK: Private properties
    private lazy var resultsViewController = ItemsBuilder.build(withItemData: nil)
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        return spinner
    }()

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

        viewModel.$state.sink { [weak self] state in
            guard let self = self else { return }

            self.spinner.stopAnimating()
            switch state {
            case .idle:
                self.dataSource.apply(self.emptySnapshot(), animatingDifferences: false)
            case .loading:
                self.spinner.startAnimating()
                self.tableView.backgroundView = self.spinner
            case .loaded(let data):
                self.dataSource.apply(self.updatedSnapshot(fromData: data), animatingDifferences: true)
            }
        }.store(in: &cancellables)
    }

    // MARK: - Private functions
    private func emptySnapshot() -> Snapshot<ItemListView.Section, ItemListView.Item> {
        var snapshot = Snapshot<ItemListView.Section, ItemListView.Item>()
        snapshot.appendSections(["main"])
        snapshot.appendItems([])
        return snapshot
    }

    private func updatedSnapshot(fromData data: [ItemData]) -> Snapshot<ItemListView.Section, ItemListView.Item> {
        var snapshot = self.dataSource.snapshot()
        var items = snapshot.itemIdentifiers
        items.append(contentsOf: data)
        snapshot.appendItems(items)
        return snapshot
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
        guard case let .loaded(data) = viewModel.state else { return }
        let categories = data.flatMap { $0.items }
        let filter = categories.filtered(from: searchText)
        resultsViewController.viewModel.items = filter
    }
}
