//
//  PokedexController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

/// A protocol for the `PokedexController` implementation
protocol PokedexViewProtocol: AnyObject {
    var interaction: AnyPublisher<PokedexView.Interaction, Never> { get }
    var viewModel: PokedexView.ViewModel { get }
}

// MARK: -
final class PokedexController: ViewController<PokedexView>, PokedexViewProtocol {

    // MARK: Private properties
    private let interactor: PokedexInteractable

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Init
    init(viewModel: PokedexView.ViewModel, interactor: PokedexInteractable) {
        self.interactor = interactor
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        interactor.loadPokemon()
    }
}
