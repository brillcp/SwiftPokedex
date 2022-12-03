//
//  ItemsController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

/// The `ItemsController` implementation
final class ItemsController: ViewController<ItemsView> {

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Init
    /// Init the `ItemsController`
    /// - parameter viewModel: The given view model for the view
    override init(viewModel: ItemsView.ViewModel) {
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.cleanTitle
    }
}
