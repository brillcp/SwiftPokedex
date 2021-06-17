//
//  PresentTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentTransition: NSObject {

    // MARK: Private properties
    private let parameters: TransitionController.Parameters
    
    // MARK: - Init
    init(parameters: TransitionController.Parameters) {
        self.parameters = parameters
        super.init()
    }
}

// MARK: -
extension PresentTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentAnimator = UIViewPropertyAnimator.presentAnimator(from: transitionContext, parameters: parameters)
        presentAnimator?.startAnimation()
    }
}
