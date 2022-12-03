//
//  PresentationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

/// A custom presentation controller used when presenting the pokemon detail view
final class PresentationController: UIPresentationController {

    // MARK: Private properties
    private lazy var fadeView: UIView = {
        let view = UIView(useAutolayout: true)
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    // MARK: - Public properties
    /// A static property for the final alpha value
    static let finalAlpha: CGFloat = 0.6

    // MARK: - Public functions
    /// Set the alpha for the fade view
    /// - parameter alpha: The given alpha value
    func setAlpha(_ alpha: CGFloat) {
        fadeView.alpha = alpha
    }
}

// MARK: - UIPresentationController delegate
extension PresentationController {

    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }

        container.addSubview(fadeView)
        fadeView.pinToSuperview()

        guard let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.alpha = Self.finalAlpha
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.alpha = Self.finalAlpha
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator, !coordinator.isInteractive else {
            fadeView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.alpha = 0.0
        })
    }
}
