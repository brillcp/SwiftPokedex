//
//  DetailViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

/// The `DetailController` implementation
final class DetailController: ViewController<DetailView> {

    // MARK: Private properties
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: color], for: .normal)
        return button
    }()

    private lazy var idButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: viewModel.id, style: .plain, target: nil, action: nil)
        let color: UIColor = viewModel.isLight ? .black : .white
        button.setTitleTextAttributes([.font: UIFont.pixel17, .foregroundColor: color], for: .normal)
        return button
    }()

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let nav = navigationController else { fatalError("No navigation here, should never happen!") }
        return nav.isBeingDismissed ? .lightContent : viewModel.isLight ? .darkContent : .lightContent
    }

    // MARK: - Init
    /// Init the `DetailController`
    /// - parameter viewModel: The given view model for the view
    override init(viewModel: DetailView.ViewModel) {
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGrey
        title = viewModel.title

        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = idButton
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavbarApp(color: .pokedexRed)
    }

    // MARK: - Private functions
    @objc private func close() {
        dismiss(animated: true)
    }
}
