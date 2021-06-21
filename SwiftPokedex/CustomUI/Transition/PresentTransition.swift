//
//  PresentTransition.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class PresentTransition: NSObject {

    // MARK: Private properties
    private let initialFrame: CGRect
    private let presenting: Bool
    
    // MARK: - Init
    init(presenting: Bool, initialFrame: CGRect) {
        self.initialFrame = initialFrame
        self.presenting = presenting
        super.init()
    }
    
    // MARK: - Private functions
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? PresentableView,
              let toView = toViewController.view,
              let snap = toView.snapshotView(afterScreenUpdates: true)
        else { return }
        
        let containerView = transitionContext.containerView
        
        toView.isHidden = true
        containerView.addSubview(toView)
        
        snap.frame = initialFrame
        containerView.addSubview(snap)
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
            snap.frame = transitionContext.finalFrame(for: toViewController)
        }
        
        animator.addCompletion { _ in
            toView.isHidden = false
            snap.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
    }
    
    private func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.8) {
            fromViewController.view.frame = self.initialFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
    }
}

// MARK: -
extension PresentTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            presentAnimation(using: transitionContext)
        } else {
            dismissAnimation(using: transitionContext)
        }
    }
}
