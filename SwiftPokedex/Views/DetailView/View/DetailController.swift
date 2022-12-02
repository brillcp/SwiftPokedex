//
//  DetailViewController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit
import Combine

protocol DetailViewProtocol: AnyObject {
    var interaction: AnyPublisher<DetailView.Interaction, Never> { get }
    var viewModel: DetailView.ViewModel { get }
}

// MARK: -
final class DetailController: ViewController<DetailView>, DetailViewProtocol {

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
        viewModel.isLight ? .default : .lightContent
    }

    // MARK: - Init
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
