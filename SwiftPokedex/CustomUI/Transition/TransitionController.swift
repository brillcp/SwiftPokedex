//
//  TransitionController.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class TransitionController: NSObject {

    // MARK: Private properties
    private let parameters: Parameters
    
    struct Parameters {
        let cellFrame: CGRect
        let image: UIImage?
        let color: UIColor?
    }

    // MARK: - Init
    init(parameters: Parameters) {
        self.parameters = parameters
        super.init()
    }
}

// MARK: -
extension TransitionController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentTransition(parameters: parameters)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissTransition(parameters: parameters)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        DismissTransition(parameters: parameters)
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
