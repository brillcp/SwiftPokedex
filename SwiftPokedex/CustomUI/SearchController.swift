//
//  SearchController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-09.
//

import UIKit

final class SearchController: UISearchController {

    // MARK: Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.searchTextField.keyboardAppearance = .dark
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        obscuresBackgroundDuringPresentation = false
        searchBar.searchTextField.font = .pixel14
        searchBar.searchBarStyle = .prominent
        searchBar.tintColor = .pokedexRed
        searchBar.placeholder = "Search…"
        searchBar.isTranslucent = false
        searchBar.isOpaque = true
    }
}
