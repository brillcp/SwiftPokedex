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
        1.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to),
              let snapshot = toView.snapshot(frame: parameters.cellFrame)
        else { return }
        
        let containerView = transitionContext.containerView

        containerView.addSubview(snapshot)
        
        var imageFrame = snapshot.frame
        imageFrame.size.height -= 35.0
        let imageView = UIImageView.detailImageView(frame: imageFrame, parameters: parameters)
        containerView.addSubview(imageView)
        
        let final = transitionContext.finalFrame(for: toViewController)
        
        let animator = UIViewPropertyAnimator(duration: 0, curve: .linear) {
            UIView.animateKeyframes(withDuration: 0, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    snapshot.alpha = 1.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    imageView.frame = CGRect(x: 0, y: 90.0, width: final.width, height: 300.0)
                    imageView.layer.cornerRadius = 40.0
                    snapshot.frame = final
                }
            }
        }
        
        animator.addCompletion { _ in
            containerView.addSubview(toView)
            imageView.removeFromSuperview()
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        animator.startAnimation()
    }
}
