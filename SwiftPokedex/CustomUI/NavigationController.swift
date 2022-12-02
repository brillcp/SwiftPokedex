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
        guard let detailView = topViewController as? DetailController else { return nil }
        return detailView.nib.tableView.tableHeaderView?.frame
    }

    override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let top = topViewController as? DetailController else { return .default }
        return top.preferredStatusBarStyle
    }
}

// MARK: -
extension UINavigationController {
    /// Set the navigation bar appearence
    /// - parameter color: The given color to set the nav bar to
    func setNavbarApp(color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pixel17, .foregroundColor: color.isLight ? UIColor.black : UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = attributes
        appearance.backgroundColor = color
        appearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
    }
}

