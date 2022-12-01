//
//  DetailView.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2022-12-01.
//

import UIKit
import Combine

final class DetailView: UIView, ViewModable, Interactable, TableViewable {

    typealias Item = AnyHashable

    // MARK: Private properties
    private let subject: PassthroughSubject<Interaction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var pokedexCollectionView: UITableView!

    // MARK: - Public properties
    var interaction: AnyPublisher<Interaction, Never> { subject.eraseToAnyPublisher() }
    var viewModel: ViewModel! { didSet { setViewModel(viewModel) } }
    var dataSource: DiffableTableDataSource<Section, Item>!
    var tableView: UITableView { pokedexCollectionView }

    enum Interaction {}

    enum Section: Int, Hashable {
        case stats
        case abilities
        case moves
        case types
    }

    // MARK: - Public functions
    func setViewModel(_ viewModel: ViewModel) {
        dataSource = tableView.detailViewDataSource(viewModel: viewModel)
        tableView.backgroundColor = .darkGrey

        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300.0)
        let header = DetailHeaderView(frame: frame, pokemon: viewModel.pokemon, color: viewModel.color)
        tableView.tableHeaderView = header
    }
}
