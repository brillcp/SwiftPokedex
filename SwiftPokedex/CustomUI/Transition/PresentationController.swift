//
//  PresentationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentationController: UIPresentationController {

    // MARK: Private properties
    private lazy var fadeView: UIView = {
        let view = UIView(useAutolayout: true)
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    // MARK: - Public properties
    static let finalAlpha: CGFloat = 0.6

    // MARK: - Public functions
    func setAlpha(_ alpha: CGFloat) {
        fadeView.alpha = alpha
    }
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }
        
        container.addSubview(fadeView)
        fadeView.pinToSuperview()

        guard let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.alpha = PresentationController.finalAlpha
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.alpha = PresentationController.finalAlpha
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
