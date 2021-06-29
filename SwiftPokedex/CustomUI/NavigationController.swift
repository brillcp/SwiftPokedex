//
//  NavigationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

final class NavigationController: UINavigationController, PresentableView {
    
    // MARK: Public properties
    var transitionManager: UIViewControllerTransitioningDelegate?

    var receivingFrame: CGRect? {
        guard let detailView = topViewController as? DetailViewController else { return nil }
        return detailView.tableView.tableHeaderView?.frame
    }
    
    override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let top = topViewController as? DetailViewController else { return .default }
        return top.preferredStatusBarStyle
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [.font: UIFont.pixel17, .foregroundColor: UIColor.white]
        navigationBar.barTintColor = .pokedexRed
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
}
