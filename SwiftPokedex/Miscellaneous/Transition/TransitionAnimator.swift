//
//  TransitionAnimator.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-16.
//

import UIKit

final class TransitionAnimator: NSObject {

    // MARK: Private properties
    private let initialFrame: CGRect
    private let image: UIImage?
    private let presenting: Bool

    // MARK: - Init
    init(presenting: Bool, interactionController: InteractableTransition) {
        self.initialFrame = interactionController.initialFrame
        self.image = interactionController.image
        self.presenting = presenting
        super.init()
    }

    // MARK: - Private functions
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? PresentableView,
              let toView = toViewController.view,
              let snap = toView.snapshotView(afterScreenUpdates: true),
              let receivingFrame = toViewController.receivingFrame
        else { return }

        let containerView = transitionContext.containerView

        toView.isHidden = true
        containerView.addSubview(toView)

        snap.clipsToBounds = true
        snap.layer.cornerRadius = PokedexCell.CornerRadius.large
        snap.frame = initialFrame
        containerView.addSubview(snap)

        let imageView = UIImageView(frame: initialFrame)
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = PokedexCell.CornerRadius.small
        containerView.addSubview(imageView)

        var newRect = receivingFrame
        newRect.origin.y += 130

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.7) {
            UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: .allowUserInteraction, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8) {
                    imageView.layer.cornerRadius = PokedexCell.CornerRadius.large
                    imageView.alpha = 0.0
                    imageView.frame = newRect
                }

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    snap.frame = transitionContext.finalFrame(for: toViewController)
                    imageView.center.x = snap.center.x
                }
            })
        }

        animator.addCompletion { _ in
            toView.isHidden = false
            snap.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        animator.startAnimation()
    }
    
    private func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? PresentableView,
              let fromView = fromViewController.view,
              let snap = fromView.snapshotView(afterScreenUpdates: false),
              let receivingFrame = fromViewController.receivingFrame
        else { return }

        let containerView = transitionContext.containerView

        fromView.isHidden = true
        snap.clipsToBounds = true
        snap.layer.cornerRadius = PokedexCell.CornerRadius.large
        containerView.addSubview(snap)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 130.0, width: receivingFrame.width, height: receivingFrame.height))
        imageView.image = image
        imageView.alpha = 0.0
        imageView.transform = fromView.transform
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)

        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                imageView.alpha = 1.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.9) {
                imageView.frame = self.initialFrame
                snap.frame = self.initialFrame
                snap.layer.cornerRadius = PokedexCell.CornerRadius.small

                if let presentation = fromViewController.presentationController as? PresentationController {
                    presentation.setAlpha(0.0)
                }
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                snap.alpha = 0.0
            }
        }, completion: { _ in
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
        })
    }
}

// MARK: -
extension TransitionAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            presentAnimation(using: transitionContext)
        } else {
            dismissAnimation(using: transitionContext)
        }
    }
}
