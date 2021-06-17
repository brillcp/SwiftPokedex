//
//  PresentationController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentationController: UIPresentationController {

    // MARK: Private properties
    private lazy var blurView: UIView = {
        let view = UIView(useAutolayout: true)
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    // MARK: - Public properties
    override var shouldRemovePresentersView: Bool { true }
    
    // MARK: - Public functions
    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }
        
        container.addSubview(blurView)
        blurView.pinToSuperview()

        presentingViewController.beginAppearanceTransition(false, animated: false)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            UIView.animate(withDuration: 0.5) { self.blurView.alpha = 0.5 }
        }, completion: nil)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }

    override func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurView.alpha = 0.0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        
        guard completed else { return }
        
        blurView.removeFromSuperview()
    }
}
