//
//  ListView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import UIKit
import Combine

final class ListView: UIView, ViewModable, Interactable, TableViewable {

    typealias Item = ItemDetails
    typealias Section = String

    // MARK: Private properties
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var listTableView: UITableView!

    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    var tableView: UITableView { listTableView }

    enum Interaction {}

    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = tableView.listViewDataSource(viewModel: viewModel)
        tableView.backgroundColor = .darkGrey

        viewModel.$items.sink { [weak self] newItems in
            guard let self = self else { return }
            var snapshot = self.dataSource.snapshot()
            var items = snapshot.itemIdentifiers
            items.append(contentsOf: newItems)
            snapshot.appendItems(items)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }.store(in: &cancellables)
    }
}
