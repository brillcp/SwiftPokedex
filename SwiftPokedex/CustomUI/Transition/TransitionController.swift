//
//  TransitionController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class TransitionController: NSObject {

    // MARK: Private properties
    private var interactionController: InteractionControlling?
    
    private var initialFrame: CGRect {
        interactionController?.initialFrame ?? .zero
    }

    // MARK: - Init
    init(interactionController: InteractionControlling) {
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
        PresentTransition(presenting: true, initialFrame: initialFrame)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentTransition(presenting: false, initialFrame: initialFrame)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactionController
    }
}
