//
//  TransitionController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class TransitionController: NSObject {

    // MARK: Private properties
    private let interactionController: InteractableTransition

    // MARK: - Init
    init(interactionController: InteractableTransition) {
        self.interactionController = interactionController
        super.init()
    }
}

// MARK: -
extension TransitionController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TransitionAnimator(isPresenting: true, interactionController: interactionController)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TransitionAnimator(isPresenting: false, interactionController: interactionController)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard interactionController.interactionInProgress else { return nil }
        return interactionController
    }
}
