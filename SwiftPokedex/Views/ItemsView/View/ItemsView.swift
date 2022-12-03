//
//  ItemsView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-02.
//

import UIKit
import Combine

/// The `ItemsView` implementation
final class ItemsView: UIView, ViewModable, Interactable, TableViewable {

    typealias Item = ItemDetails
    typealias Section = String

    // MARK: Private properties
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var itemsTableView: UITableView!

    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    var tableView: UITableView { itemsTableView }

    enum Interaction {}

    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = tableView.itemsDataSource(viewModel: viewModel)
        tableView.backgroundColor = .darkGrey

        viewModel.$items.sink { data in
            var snap = NSDiffableDataSourceSnapshot<ItemsView.Section, ItemsView.Item>()
            snap.appendSections(["main"])
            snap.appendItems(data)
            self.dataSource.apply(snap, animatingDifferences: false)
        }.store(in: &cancellables)
    }
}
