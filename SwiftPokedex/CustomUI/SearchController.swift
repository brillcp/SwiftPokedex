//
//  SearchController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-09.
//

import UIKit

final class SearchController: UISearchController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search…"
        searchBar.tintColor = .pokedexRed
        searchBar.searchTextField.font = .pixel14
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.keyboardAppearance = .dark
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = false
    }
}
