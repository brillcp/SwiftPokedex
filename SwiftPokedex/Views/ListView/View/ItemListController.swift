//
//  ItemListController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

/// A protocol for the `ItemListController` implementation
protocol ItemListViewProtocol: AnyObject {
    var interaction: AnyPublisher<ItemListView.Interaction, Never> { get }
    var viewModel: ItemListView.ViewModel { get }
}

// MARK: -
/// The `ItemListController` implementation
final class ItemListController: ViewController<ItemListView>, ItemListViewProtocol {

    // MARK: Private properties
    private let interactor: ItemListInteractable

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Init
    /// Init the `ItemListController`
    /// - parameters:
    ///     - viewModel: The given view model for the view
    ///     - interactor: The interactor object used to interact with the view
    init(viewModel: ItemListView.ViewModel, interactor: ItemListInteractable) {
        self.interactor = interactor
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = nib.searchController
        title = viewModel.title
        interactor.loadItems()
    }
}
